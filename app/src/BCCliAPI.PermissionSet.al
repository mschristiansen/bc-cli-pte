permissionset 50300 "BC Cli API"
{
    Assignable = true;
    Caption = 'BC Cli API';

    Permissions =
        tabledata Customer = RM,
        tabledata "Sales Header" = RM,
        tabledata "Production Order" = RM;
}
