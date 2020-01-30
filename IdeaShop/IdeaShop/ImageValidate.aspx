<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="ImageValidate.aspx.cs" Inherits="IdeaShop.ImageValidate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h2><asp:Label ID="lblTop" runat="server" Text="Validate Images"></asp:Label></h2>
        <hr />
    <div class ="validateFlex">
    <asp:Repeater ID="rptItems" runat="server" OnItemCommand="rptItems_ItemCommand">
        <ItemTemplate>
            <div>
                <h3>ID: <%#Eval("ID_Img") %></h3>
                <div class ="justCenter">
                    <asp:Image ID="leImage" runat="server" ImageUrl ='<%#Eval("locus") %>'  Width="50%"/><br />
                    <h5><%#Eval("fileName") %></h5>
                    <asp:Button ID="btnAccept" CommandArgument = '<%#Eval("ID_Img") %>' CommandName="Accept" runat="server" Text="Accept" UseSubmitBehavior="false"/>
                    <asp:Button ID="btnReject" CommandArgument = '<%#Eval("ID_Img") %>' CommandName="Reject" runat="server" Text="Reject" UseSubmitBehavior="false" />
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    </div>
</asp:Content>
