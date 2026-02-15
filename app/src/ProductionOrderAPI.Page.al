page 50302 "Production Order API"
{
    PageType = API;
    APIPublisher = 'mschristiansen';
    APIGroup = 'bcCli';
    APIVersion = 'v1.0';
    EntityName = 'productionOrder';
    EntitySetName = 'productionOrders';
    EntityCaption = 'Production Order';
    EntitySetCaption = 'Production Orders';
    SourceTable = "Production Order";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'Number';
                    Editable = false;
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time';
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                }
                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time';
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(release)
            {
                Caption = 'Release';

                trigger OnAction()
                var
                    ChangeProdOrderStatus: Codeunit "Prod. Order Status Management";
                begin
                    ChangeProdOrderStatus.ChangeProdOrderStatus(Rec, Rec.Status::Released, WorkDate(), false);
                end;
            }
            action(finish)
            {
                Caption = 'Finish';

                trigger OnAction()
                var
                    ChangeProdOrderStatus: Codeunit "Prod. Order Status Management";
                begin
                    ChangeProdOrderStatus.ChangeProdOrderStatus(Rec, Rec.Status::Finished, WorkDate(), false);
                end;
            }
        }
    }
}
