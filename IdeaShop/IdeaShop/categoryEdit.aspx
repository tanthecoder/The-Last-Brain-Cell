<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="categoryEdit.aspx.cs" Inherits="IdeaShop.categoryEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="~/MyStyles/categoryEdit.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    <h3 id ="btnBack"><a href ="AdminSection.aspx">&lt;Back</a></h3>
    <h1>Category Editor
        <small>
            Category ID:<asp:Label ID="ID_Cat" runat="server" Text=""></asp:Label></small>
    </h1><asp:DropDownList ID="ddlCategories" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategories_TextChanged"></asp:DropDownList><!--Wire this to the staus table, you might want to insert a blank row, You should find a commented out example in the code-behind-->
    <hr />
    <asp:TextBox ID="cat_name" runat="server" Width ="90%" placeholder="Category Name"></asp:TextBox><asp:RequiredFieldValidator ID="rfvCatName" runat="server" ControlToValidate="cat_name" ForeColor="Red" ErrorMessage="Category Name is Required">*</asp:RequiredFieldValidator>
    <asp:TextBox ID="description" TextMode ="MultiLine" Rows ="2" runat="server" Width = "100%" placeholder="Description (200 characters max)"></asp:TextBox>
    <div id ="btnHolder">
        <asp:Button ID="btnNew" runat="server" Text="New" OnClick="btnNew_Click" />&nbsp;
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />&nbsp;
        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CausesValidation="False" />
        <asp:Button ID="btnConfirm" runat="server" OnClick="btnConfirm_Click" Text="Confirm Delete" visible="false"/>
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" Visible="false" OnClick="btnCancel_Click" CausesValidation="False" />

    </div>
</asp:Content>
