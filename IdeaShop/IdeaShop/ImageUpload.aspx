<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="ImageUpload.aspx.cs" Inherits="IdeaShop.ImageUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><asp:Label ID="lblTop" runat="server" Text="Upload Images"></asp:Label></h2>
        <hr />
    <div class ="col-md-12">
    <asp:FileUpload ID="imgUploader" runat="server" style ="display:inline-block; "/><asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
    </div>
    <div class ="col-md-4" id ="imgPreviewHolder" runat="server">
     <asp:Image ID="imgPreview" runat="server" Width ="90%" />
        
    </div>
    <div id ="imgDeets" class ="col-md-8" runat ="server">
        <h3><asp:Label ID="lblFileName" runat="server" Text=""></asp:Label></h3>
        <asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label> <asp:TextBox ID="txtName" runat="server" MaxLength="15"></asp:TextBox></br>
        <asp:Label ID="Label2" runat="server" Text="Alt Text:"></asp:Label> <asp:TextBox ID="txtAltText" runat="server" MaxLength="50"></asp:TextBox></br>
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />

    </div>
</asp:Content>
