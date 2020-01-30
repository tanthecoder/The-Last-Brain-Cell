<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="IdeaShop.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><asp:Label ID="lblTop" runat="server" Text="Admin Login"></asp:Label></h2>
        <hr />
    <h3><asp:Label ID="Label1" runat="server" Text="Email: " class ="solidLabel"></asp:Label><asp:TextBox ID="txtEmail" runat="server"></asp:TextBox></h3>
    <h3><asp:Label ID="Label2" runat="server" Text ="Password: " class ="solidLabel"></asp:Label><asp:TextBox ID="txtPassword" TextMode ="password" runat="server"></asp:TextBox></h3>
    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
</asp:Content>
