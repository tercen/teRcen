createObjectFromJson = function(json) {
    kind = json$kind
    if (kind == "Ace") {
        return(Ace$new(json = json))
    }
    if (kind == "Team") {
        return(Team$new(json = json))
    }
    if (kind == "InStep") {
        return(InStep$new(json = json))
    }
    if (kind == "DoubleProperty") {
        return(DoubleProperty$new(json = json))
    }
    if (kind == "JoinMeltOperator") {
        return(JoinMeltOperator$new(json = json))
    }
    if (kind == "Rectangle") {
        return(Rectangle$new(json = json))
    }
    if (kind == "RunningState") {
        return(RunningState$new(json = json))
    }
    if (kind == "Labels") {
        return(Labels$new(json = json))
    }
    if (kind == "WhereRelation") {
        return(WhereRelation$new(json = json))
    }
    if (kind == "RSourceOperator") {
        return(RSourceOperator$new(json = json))
    }
    if (kind == "OperatorSettings") {
        return(OperatorSettings$new(json = json))
    }
    if (kind == "CubeQueryTableSchema") {
        return(CubeQueryTableSchema$new(json = json))
    }
    if (kind == "CategoryPalette") {
        return(CategoryPalette$new(json = json))
    }
    if (kind == "IntegerProperty") {
        return(IntegerProperty$new(json = json))
    }
    if (kind == "Property") {
        return(Property$new(json = json))
    }
    if (kind == "ModelStep") {
        return(ModelStep$new(json = json))
    }
    if (kind == "Filters") {
        return(Filters$new(json = json))
    }
    if (kind == "ChartHeatmap") {
        return(ChartHeatmap$new(json = json))
    }
    if (kind == "Point") {
        return(Point$new(json = json))
    }
    if (kind == "Column") {
        return(Column$new(json = json))
    }
    if (kind == "CubeQuery") {
        return(CubeQuery$new(json = json))
    }
    if (kind == "User") {
        return(User$new(json = json))
    }
    if (kind == "Filter") {
        return(Filter$new(json = json))
    }
    if (kind == "GroupStep") {
        return(GroupStep$new(json = json))
    }
    if (kind == "Errors") {
        return(Errors$new(json = json))
    }
    if (kind == "FailedState") {
        return(FailedState$new(json = json))
    }
    if (kind == "Palette") {
        return(Palette$new(json = json))
    }
    if (kind == "UserSession") {
        return(UserSession$new(json = json))
    }
    if (kind == "CanceledState") {
        return(CanceledState$new(json = json))
    }
    if (kind == "GraphicalFactor") {
        return(GraphicalFactor$new(json = json))
    }
    if (kind == "RenameRelation") {
        return(RenameRelation$new(json = json))
    }
    if (kind == "Table") {
        return(Table$new(json = json))
    }
    if (kind == "ChartLine") {
        return(ChartLine$new(json = json))
    }
    if (kind == "ColorList") {
        return(ColorList$new(json = json))
    }
    if (kind == "Acl") {
        return(Acl$new(json = json))
    }
    if (kind == "RelationStep") {
        return(RelationStep$new(json = json))
    }
    if (kind == "DataStep") {
        return(DataStep$new(json = json))
    }
    if (kind == "ChartSize") {
        return(ChartSize$new(json = json))
    }
    if (kind == "CubeAxisQuery") {
        return(CubeAxisQuery$new(json = json))
    }
    if (kind == "JoinOperator1") {
        return(JoinOperator1$new(json = json))
    }
    if (kind == "ColorElement") {
        return(ColorElement$new(json = json))
    }
    if (kind == "RampPalette") {
        return(RampPalette$new(json = json))
    }
    if (kind == "OutStep") {
        return(OutStep$new(json = json))
    }
    if (kind == "Token") {
        return(Token$new(json = json))
    }
    if (kind == "InputPort") {
        return(InputPort$new(json = json))
    }
    if (kind == "JoinOperator") {
        return(JoinOperator$new(json = json))
    }
    if (kind == "PropertyValue") {
        return(PropertyValue$new(json = json))
    }
    if (kind == "CSVFileMetadata") {
        return(CSVFileMetadata$new(json = json))
    }
    if (kind == "TableStepModel") {
        return(TableStepModel$new(json = json))
    }
    if (kind == "ComputationTask") {
        return(ComputationTask$new(json = json))
    }
    if (kind == "DoneState") {
        return(DoneState$new(json = json))
    }
    if (kind == "AclContext") {
        return(AclContext$new(json = json))
    }
    if (kind == "CrosstabTable") {
        return(CrosstabTable$new(json = json))
    }
    if (kind == "StepModel") {
        return(StepModel$new(json = json))
    }
    if (kind == "TableStep") {
        return(TableStep$new(json = json))
    }
    if (kind == "FilterTopExpr") {
        return(FilterTopExpr$new(json = json))
    }
    if (kind == "MeltStep") {
        return(MeltStep$new(json = json))
    }
    if (kind == "UnionRelation") {
        return(UnionRelation$new(json = json))
    }
    if (kind == "XYAxisList") {
        return(XYAxisList$new(json = json))
    }
    if (kind == "DoubleColorElement") {
        return(DoubleColorElement$new(json = json))
    }
    if (kind == "Step") {
        return(Step$new(json = json))
    }
    if (kind == "Crosstab") {
        return(Crosstab$new(json = json))
    }
    if (kind == "State") {
        return(State$new(json = json))
    }
    if (kind == "Task") {
        return(Task$new(json = json))
    }
    if (kind == "Operator") {
        return(Operator$new(json = json))
    }
    if (kind == "ColumnSchemaMetaData") {
        return(ColumnSchemaMetaData$new(json = json))
    }
    if (kind == "Privilege") {
        return(Privilege$new(json = json))
    }
    if (kind == "OperatorRef") {
        return(OperatorRef$new(json = json))
    }
    if (kind == "Port") {
        return(Port$new(json = json))
    }
    if (kind == "ViewDataStep") {
        return(ViewDataStep$new(json = json))
    }
    if (kind == "JoinStep") {
        return(JoinStep$new(json = json))
    }
    if (kind == "CSVTask") {
        return(CSVTask$new(json = json))
    }
    if (kind == "CubeQueryTask") {
        return(CubeQueryTask$new(json = json))
    }
    if (kind == "WizardStep") {
        return(WizardStep$new(json = json))
    }
    if (kind == "JoinStepModel") {
        return(JoinStepModel$new(json = json))
    }
    if (kind == "WizardStepModel") {
        return(WizardStepModel$new(json = json))
    }
    if (kind == "Factor") {
        return(Factor$new(json = json))
    }
    if (kind == "InitState") {
        return(InitState$new(json = json))
    }
    if (kind == "SimpleRelation") {
        return(SimpleRelation$new(json = json))
    }
    if (kind == "JetPalette") {
        return(JetPalette$new(json = json))
    }
    if (kind == "ChartPoint") {
        return(ChartPoint$new(json = json))
    }
    if (kind == "ColumnPair") {
        return(ColumnPair$new(json = json))
    }
    if (kind == "FilterExpr") {
        return(FilterExpr$new(json = json))
    }
    if (kind == "TableSchema") {
        return(TableSchema$new(json = json))
    }
    if (kind == "Date") {
        return(Date$new(json = json))
    }
    if (kind == "SourceOperator") {
        return(SourceOperator$new(json = json))
    }
    if (kind == "StepState") {
        return(StepState$new(json = json))
    }
    if (kind == "ProjectDocument") {
        return(ProjectDocument$new(json = json))
    }
    if (kind == "OperatorResult") {
        return(OperatorResult$new(json = json))
    }
    if (kind == "FileDocument") {
        return(FileDocument$new(json = json))
    }
    if (kind == "Document") {
        return(Document$new(json = json))
    }
    if (kind == "CrossTabStep") {
        return(CrossTabStep$new(json = json))
    }
    if (kind == "OutputPort") {
        return(OutputPort$new(json = json))
    }
    if (kind == "PersistentObject") {
        return(PersistentObject$new(json = json))
    }
    if (kind == "Link") {
        return(Link$new(json = json))
    }
    if (kind == "StringProperty") {
        return(StringProperty$new(json = json))
    }
    if (kind == "XYAxis") {
        return(XYAxis$new(json = json))
    }
    if (kind == "IdObject") {
        return(IdObject$new(json = json))
    }
    if (kind == "Principal") {
        return(Principal$new(json = json))
    }
    if (kind == "Attribute") {
        return(Attribute$new(json = json))
    }
    if (kind == "Project") {
        return(Project$new(json = json))
    }
    if (kind == "Url") {
        return(Url$new(json = json))
    }
    if (kind == "Workflow") {
        return(Workflow$new(json = json))
    }
    if (kind == "StringColorElement") {
        return(StringColorElement$new(json = json))
    }
    if (kind == "EnumeratedProperty") {
        return(EnumeratedProperty$new(json = json))
    }
    if (kind == "NamedFilter") {
        return(NamedFilter$new(json = json))
    }
    if (kind == "NamespaceStep") {
        return(NamespaceStep$new(json = json))
    }
    if (kind == "ExternalOperator") {
        return(ExternalOperator$new(json = json))
    }
    if (kind == "MeltStepModel") {
        return(MeltStepModel$new(json = json))
    }
    if (kind == "Pair") {
        return(Pair$new(json = json))
    }
    if (kind == "InMemoryRelation") {
        return(InMemoryRelation$new(json = json))
    }
    if (kind == "Axis") {
        return(Axis$new(json = json))
    }
    if (kind == "Relation") {
        return(Relation$new(json = json))
    }
    if (kind == "BooleanProperty") {
        return(BooleanProperty$new(json = json))
    }
    if (kind == "ViewStep") {
        return(ViewStep$new(json = json))
    }
    if (kind == "Colors") {
        return(Colors$new(json = json))
    }
    if (kind == "FileMetadata") {
        return(FileMetadata$new(json = json))
    }
    if (kind == "CompositeRelation") {
        return(CompositeRelation$new(json = json))
    }
    if (kind == "ColumnSchema") {
        return(ColumnSchema$new(json = json))
    }
    if (kind == "ComputedTableSchema") {
        return(ComputedTableSchema$new(json = json))
    }
    if (kind == "TableProperties") {
        return(TableProperties$new(json = json))
    }
    if (kind == "AxisSettings") {
        return(AxisSettings$new(json = json))
    }
    if (kind == "MappingFactor") {
        return(MappingFactor$new(json = json))
    }
    if (kind == "Chart") {
        return(Chart$new(json = json))
    }
    if (kind == "ChartBar") {
        return(ChartBar$new(json = json))
    }
    if (kind == "Worker") {
        return(Worker$new(json = json))
    }
    if (kind == "GroupByRelation") {
        return(GroupByRelation$new(json = json))
    }
    if (kind == "UserSecret") {
        return(UserSecret$new(json = json))
    }
    stop("bad kind")
}
