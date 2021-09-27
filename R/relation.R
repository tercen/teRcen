#' @export
save_relation = function(object,ctx){
  if (inherits(object, 'JoinOperator')){
    joins = list(object)
  } else if (inherits(object, 'list')){
    check = lapply(object, function(x) inherits(x, 'JoinOperator'))
    if (!all(check)){
      stop('ctx.save_relation -- a list of JoinOperator is required')
    }
    joins = object
  }
  
  tables = new.env()
  add.table = function(table){
    tables[[toString(length(tables)+1)]] = table
  }
  
  lapply(joins, function(jop){
    jop$rightRelation = convert.inmemory.relation(add.table, jop$rightRelation)
  })
  
  result = OperatorResult$new()
  result$tables = unname(as.list(tables))
  result$joinOperators = joins
  
  ctx$save(result)
  
  invisible(result)
}

inmemory.to.simple = function(add.table, inmemory){
  relation = SimpleRelation$new()
  relation$id = inmemory$inMemoryTable$properties$name
  add.table(inmemory$inMemoryTable)
  relation
}

convert.inmemory.relation = function(add.table, relation){
  if (inherits(relation,"SimpleRelation")) {
    
  } else if (inherits(relation,"InMemoryRelation")) {
    return(inmemory.to.simple(add.table, relation))
  } else if (inherits(relation,"CompositeRelation")) {
    rel = relation$mainRelation
    if (inherits(rel, 'InMemoryRelation')){
      relation$mainRelation = inmemory.to.simple(add.table, rel)
    } else {
      convert.inmemory.relation(add.table, rel)
    }
    
    lapply(relation$joinOperators, function(jop){
      rel = jop$rightRelation
      if (inherits(rel, 'InMemoryRelation')){
        jop$rightRelation = inmemory.to.simple(add.table, rel)
      } else {
        convert.inmemory.relation(add.table, rel)
      }
    })
  } else if (inherits(relation,"WhereRelation") 
             || inherits(relation,"RenameRelation")) {
    rel = relation$relation
    if (inherits(rel, 'InMemoryRelation')){
      relation$relation = inmemory.to.simple(add.table, rel)
    } else {
      convert.inmemory.relation(add.table, rel)
    }
  } else if (inherits(relation,"UnionRelation")) {
    relation$relations = lapply(relation$relations, function(rel){
      if (inherits(rel, 'InMemoryRelation')){
        return(inmemory.to.simple(add.table, rel))
      } else {
        convert.inmemory.relation(add.table, rel)
        return(rel)
      }
    })
  } else {
    stop('convert.inmemory.relation -- not impl')
  }
  return(relation)
}
  
#' @export
as_relation = function(object) {
  if (inherits(object, 'Relation')) {
    return(object)
  } else if (inherits(object, 'data.frame')){
    tbl = tercen::dataframe.as.table(object)
  } else if (inherits(object, 'Table')) {
    tbl = object
  } else if (inherits(object, 'Schema')) {
    relation = SimpleRelation$new()
    relation$id = object$id
    return(relation)
  } else {
    stop('as_relation -- data.frame or tercen::Table is required')
  }
  relation = InMemoryRelation$new()
  relation$id = uuid::UUIDgenerate()
  tbl$properties$name = relation$id
  relation$inMemoryTable = tbl
  relation
}

#' @export
as_composite_relation = function(object) {
  relation = as_relation(object)
  if (inherits(relation, 'CompositeRelation')){
    composite = relation
  } else if (inherits(relation, 'Relation')) {
    composite = CompositeRelation$new()
    composite$id = uuid::UUIDgenerate()
    composite$mainRelation = relation
  } else {
    stop('as_composite_relation -- a tercen::Relation is required')
  }
  composite
}

#' @export
left_join_relation = function(left, right, lby, rby) {
  compositeRelation = as_composite_relation(left)
  compositeRelation$joinOperators = unname(unlist(list(compositeRelation$joinOperators,
                                                       as_join_operator(right, lby,rby))))
  compositeRelation
}

#' @export
as_join_operator = function(object, lby, rby) {
  relation = as_relation(object)
  join = JoinOperator$new()
  join$rightRelation = relation
  join$leftPair = mk.pair(lby,rby)  
  join
} 

#' @export
mk.pair = function(lColumns, rColumns) {
  pair = ColumnPair$new()
  pair$lColumns = unname(as.list(lColumns))
  pair$rColumns = unname(as.list(rColumns))
  pair
}