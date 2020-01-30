
<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="IdeaShop.product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <meta name = "viewport" content = "width=device-width, initial-scale = 1.0">
    <link href="MyStyles/product.css" rel="stylesheet" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Extract the id from the IDPR and use the proper stored procedure to populate this page-->
    <h2>
        <asp:Label ID="pro_name" runat="server" Text="pro_name"></asp:Label>
        <small>Product Id: <asp:Label ID="ID_Pr" runat="server" Text=""></asp:Label></small>
    </h2><!--Pro name goes here-->
    <asp:Label ID="featured" runat="server" Text="" ForeColor ="Lime"></asp:Label><!--Unless the product is featued this remains blank-->
    <hr />
    <div class ="justCenter">
        <h3 id ="btnBack"><a href ="default.aspx">&lt;Back</a></h3>
        <asp:Image ID="pic" class ="prodImg" runat="server" /><!--Reminder: You might have to hide and unhide an image to get it to cooperate-->
        <h3>Category: <asp:Label ID="cat_name" runat="server" Text=""></asp:Label><br /><!--Put cat_name here-->
            <asp:Label ID="price" runat="server" Text="price"></asp:Label> <!--price goes here-->
        </h3>
        
        <div id ="descriptionHolder">
            <small>Brief Description: </br><asp:Label ID="descriptionBrief" class ="gray-italic" runat="server" Text="descriptionBrief"></asp:Label></small><br>
            <label>Description: </label></br>
            <asp:Label ID="descriptionFull" runat="server" Text="descriptionFull"></asp:Label>
            <p><asp:Label ID="str_stat" runat="server" Text="str_stat"></asp:Label></p><!--The column str_stat is a string value of the status returned in the -->
        </div>
        <div id = "optionTray">
            <div class ="col-sm-10">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label><!--This is your output label, remember to clear it on startup-->
            </div>
            <div class ="col-sm-2">
                <asp:Label ID="lblQty" runat="server" Text="qty"></asp:Label>
                <asp:TextBox TextMode = "Number" ID="nudIntoCart" runat="server" min ="1" max ="10" Text ="1"></asp:TextBox>
                <asp:Button ID="btnAddCart" runat="server" Text="Add To Cart" OnClick="btnAddCart_Click" />
                <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" Visible ="false" />
            </div>
        </div>
    </div>

    
</asp:Content>
