<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="ImageEdit.aspx.cs" Inherits="IdeaShop.ImageEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h2><asp:Label ID="lblTop" runat="server" Text="Edit Images"></asp:Label></h2>
        <hr />

    <div>
        <asp:DropDownList ID="ddlImages" runat="server"></asp:DropDownList>
        <asp:Button ID="btnImage" runat="server" Text="Load Selected Image" OnClick="btnImage_Click" />
        <asp:TextBox ID="txtSearch" runat="server" Visible="False"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" Visible="False" />
    </div>
        <div class ="col-md-4">
        <asp:Image ID="imgPreview" runat="server" Width ="90%"/>
    </div>
    <div id ="imgDeets" class ="col-md-8" runat ="server">
        <h3><asp:Label ID="lblFileName" runat="server" Text=""></asp:Label></h3>
        <asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label> <asp:TextBox ID="txtName" runat="server"></asp:TextBox></br>
        <asp:Label ID="Label2" runat="server" Text="Alt Text:"></asp:Label> <asp:TextBox ID="txtAltText" runat="server"></asp:TextBox></br>
        <asp:CheckBox ID="chkActive" runat="server" Text ="Active/ Permitted for viewing on the site" /></br>
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="DeleteClick" />
        <asp:Button ID="btnDontDelete" runat="server" Text="Cancel Delete" OnClick="DeleteClick" />
        <asp:Button ID="btnRealDelete" runat="server" Text="Confirm Delete" OnClick="DeleteClick" />
        </div>
</asp:Content>
