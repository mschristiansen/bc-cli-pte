permissionset 50300 "BC Cli API"
{
    Assignable = true;
    Caption = 'BC Cli API';

    Permissions =
        page "Customer API" = X,
        page "Sales Order API" = X,
        page "Production Order API" = X,
        tabledata Customer = RM,
        tabledata "Sales Header" = RM,
        tabledata "Production Order" = RM,
        codeunit "Prod. Order Status Management" = X;
}
