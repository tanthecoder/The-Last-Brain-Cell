<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="AdminSection.aspx.cs" Inherits="IdeaShop.AdminSection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Welcome Mr.Admin!</h1>
    <h2>Please make a selection:</h2>
    <h3><a href="categoryEdit.aspx">Category editor</a></h3>
    <h3><a href="productEdit.aspx">Product Editor</a></h3>
    <h3><a href="AccountEditorAdmin.aspx">Account Editor</a></h3>
    <h3><a href="AccountEditor.aspx">Create Account</a></h3>
    <h3><a href="ImageUpload.aspx">Image Uploader</a></h3>
    <h3><a href="ImageEdit.aspx">Image Editor</a></h3>
    <h3><a href="ImageValidate.aspx">Image Validator</a></h3>


</asp:Content>
