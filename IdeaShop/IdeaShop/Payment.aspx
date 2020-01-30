<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="IdeaShop.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><asp:Label ID="lblTop" runat="server" Text="Your Shopping Cart"></asp:Label><small> <%=DateTime.Now %></small></h2>
        <hr />
    <div  id ="checkoutCrumb" runat ="server">Cart >Edit Info >  Shipping Address > <span class ="justRed">Payment </span> > Ordered!</div>
    <div class ="checkoutAddress">
    <h5>Payment Type</h5>
        <asp:DropDownList ID="ddlPayment" runat="server">
            <asp:ListItem Selected="True" Value="NULL">Choose A Payment Type</asp:ListItem>
            <asp:ListItem Value="Visa"></asp:ListItem>
            <asp:ListItem Value="MasterCard"></asp:ListItem>

        </asp:DropDownList>
        <asp:Button ID="btnContinue" runat="server" Text="Comfirm Payment" OnClick="btnContinue_Click" />
    </div>
</asp:Content>
