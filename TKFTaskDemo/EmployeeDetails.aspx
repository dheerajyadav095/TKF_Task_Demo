<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeDetails.aspx.cs" Inherits="TKFTaskDemo.EmployeeDetails" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js" integrity="sha512-aFvi2oPv3NjnjQv1Y/hmKD7RNMendo4CZ2DwQqMWzoURKxcqAoktj0nNG4LU8m23+Ws9X5uVDD4OXLqpUVXD5Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" integrity="sha512-EvvoSMXERW4Pe9LjDN9XDzHd66p8Z49gcrB7LCUplh0GcEHiV816gXGwIhir6PJiwl0ew8GFM2QaIg2TW02B9A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script type="text/javascript">
        $(function () {
            $('[id*=txtDOB]').datepicker({
                changeMonth: true,
                changeYear: true,
                format: "mm/dd/yyyy",
                language: "tr"
            });
        });
        $(function () {
            $('[id*=lstSkills]').multiselect
                ({
                    includeSelectAllOption: true,
                    nonSelectedText: 'Select Skills'
                });
        });
    </script>

    <style type="text/css">
        .heading {
            padding-left: 40%;
            padding-top: 200px;
            font-size: 55px;
        }

        .field-name {
            width: 150px;
        }

        .auto-style1 {
            width: 28%;
            float: left;
            height: 391px;
        }

        .multiselect, .multiselect-native-select, .btn-group, .multiselect-container {
            width: 100%;
        }

        .multiselect-selected-text {
            float: left;
            font-size: 13px;
        }

        .caret {
            float: right;
            margin-top: 7px;
        }
    </style>
</head>

<body style="padding-top: 60px;">

    <form id="form1" runat="server">

        <span class="heading">IKF Task</span>

        <div style="width: 95%; padding: 50px,0,0,50px;">

            <div style="padding-left: 5%; padding-top: 10px;" class="auto-style1">

                <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td class="field-name">Name:<br />
                        </td>
                        <td>
                            <asp:HiddenField ID="hdnUpdatedEmpID" runat="server"></asp:HiddenField>
                            <asp:TextBox ID="txtName" runat="server" Style="width: 200px;" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="reqName" ControlToValidate="txtName" ValidationGroup="EmpForm" runat="server" ToolTip="Please Enter Name" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="field-name">Date Of Birth:<br />
                        </td>
                        <td>

                            <asp:TextBox ID="txtDOB" runat="server" AutoPostBack="False" TabIndex="1" placeholder="MM/DD/YYYY" autocomplete="off" MaxLength="10" Width="100%"></asp:TextBox>

                        </td>
                        <td>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtDOB" ValidationGroup="EmpForm" runat="server" ToolTip="Please Enter Date only." ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                      <tr>
                        <td>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="field-name">Designation:<br />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDesignation" runat="server" Style="width: 200px;" />

                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDesignation" ValidationGroup="EmpForm" runat="server" ToolTip="Please Enter Designation" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field-name">Skills:<br />
                        </td>
                        <td>
                            <asp:ListBox ID="lstSkills" runat="server" SelectionMode="Multiple"></asp:ListBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="lstSkills" ValidationGroup="EmpForm" runat="server" ErrorMessage="*" ToolTip="Please select some items" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                    </tr>
                    <tr align="center">

                        <td class="field-name" colspan="2">
                            <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="EmpForm" class="btn btn-primary" OnClick="btnSave_Click" />
                            &nbsp;
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-primary" OnClick="btnCancel_Click" />
                        </td>

                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                    </tr>
                </table>

            </div>

            <div style="float: left; width: 70%; padding-top: 20px; padding-left: 6%;">

                <asp:GridView ID="dgEmployeeDetails" DataKeyNames="EmpID" runat="server" Width="1080px"
                    BorderColor="LightGray" BorderWidth="1px" AutoGenerateColumns="False" AllowSorting="true" OnRowCancelingEdit="OnRowCancelingEdit"
                    PageSize="5" AllowPaging="true" OnRowEditing="OnRowEditing" OnRowUpdating="OnRowUpdating" OnPageIndexChanging="OnPaging" OnRowDeleting="OnRowDeleting">
                    <HeaderStyle Font-Bold="True" BackColor="#EEEEEE"></HeaderStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="" Visible="false" ItemStyle-Height="50px" HeaderStyle-Height="50px" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblEmpID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EmpID")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" ItemStyle-Height="50px" HeaderStyle-Height="30px" HeaderStyle-Width="100px" HeaderStyle-VerticalAlign="Middle">
                            <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "EmpName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date of birth" ItemStyle-Height="50px" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem,"EmpDOB")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Designation" ItemStyle-Height="50px" HeaderStyle-Width="150px">
                            <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "EmpDesignation")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Skills" ItemStyle-Height="50px" HeaderStyle-Width="120px">
                            <ItemTemplate>
                                <%#DataBinder.Eval(Container.DataItem, "SkillName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </form>

</body>
</html>
