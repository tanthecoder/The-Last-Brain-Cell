<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="productEdit.aspx.cs" Inherits="IdeaShop.productEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="MyStyles/product.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <!--Extract the id from the IDPR and use the proper stored procedure to populate this page-->
    <h2>
        <label>Product Name:</label> <asp:TextBox ID="pro_nameTxt" placeholder ="Product Name" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Product Name is Required" ControlToValidate="pro_nameTxt" ForeColor="Red">*</asp:RequiredFieldValidator><!--Pro name goes here-->
        <small><asp:Label ID="ID_Pr" runat="server" Text="Product ID:"></asp:Label></small><!--Pro id goes here-->
    </h2>
    <asp:CheckBox ID="isFeaturedChk" runat="server" Text="Featured" AutoPostBack="True"/>
    <hr />
    <div class ="justCenter">

        <h3 id ="btnBack"><a href ="AdminSection.aspx">&lt;Back</a></h3>
        <!--Contains dropdown lists for choosing-->
        <div class ="well peChoose">
            <label>Category: </label><asp:DropDownList ID="ddlCategoryChoose" runat="server" ></asp:DropDownList><asp:Button ID="btnNewProduct" runat="server" Text="New Product" OnClick="btnNewProduct_Click" CausesValidation="False" /><asp:Button ID="btnLoadProducts" runat="server" Text="Load Products" OnClick="LoadProducts" CausesValidation="False" /><br />
            <label id ="lblProduct" runat ="server">Product: </label><asp:DropDownList ID="ddlProductChoose" runat="server" AutoPostBack="True"></asp:DropDownList><asp:Button ID="btnLoadProduct" runat="server" Text="Load Selected Product" OnClick="loadSelectedProduct" CausesValidation="False" />
        </div>

        <asp:Image ID="pic" runat="server" ImageUrl="~/images/notavailable.png" Width ="150px" /><br /><!--Reminder: You might have to hide and unhide an image to get it to cooperate-->
        <label>Image File: </label><asp:TextBox ID="picTxt" runat="server" placeholder="notavailable.png"></asp:TextBox><asp:Button ID="btnImgtry" runat="server" Text="Test Image" OnClick="btnImgtry_Click" />
        <h3><label>Category: </label><asp:DropDownList ID="ddlCategoriesEdit" runat="server"></asp:DropDownList><br /><!--Populate with categories and their values-->
           <label>Price: </label>
               $<asp:TextBox TextMode="Number" step = "0.01" ID ="priceTxt" runat="server" placeholder="0.00"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Price is Required" ControlToValidate="priceTxt" ForeColor="Red">*</asp:RequiredFieldValidator> <!--price goes here-->
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter a price in the valid format (N.NN)" ControlToValidate="priceTxt" ValidationExpression="^[0-9]+(\.[0-9]{1,2})?$" ForeColor="Red">*</asp:RegularExpressionValidator><!--From : https://www.regextester.com/97725-->
        </h3>
        
        <div id ="descriptionHolder">
            <h4>&nbsp;Brief Description</h4>
            <asp:TextBox ID="descriptionBriefTxt" class ="desBox" runat="server" placeholder = "Brief Description" Width ="95%"  Rows="1"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Description Brief is Required" ControlToValidate="descriptionBriefTxt" ForeColor="Red">*</asp:RequiredFieldValidator>
            <h4>Full Description</h4>
            <asp:TextBox ID="descriptionFullTxt" TextMode ="MultiLine" class ="desBox" runat="server" placeholder = "Full Description" Width ="95%"  Rows="3"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Description Full is Required" ControlToValidate="descriptionFullTxt" ForeColor="Red">*</asp:RequiredFieldValidator>
            
            <p><asp:Label ID="str_stat" runat="server" Text="status "></asp:Label><asp:DropDownList ID="str_statDdl" runat="server"></asp:DropDownList></p><!--Dill from the StatusStatic table-->
        </div>
        <div id = "optionTray">
            <div class ="col-sm-2">
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label><!--This is your output label, remember to clear it on startup-->
            </div>
            <div class ="col-sm-10 editBTNTray"><!--You should make some elements disappear depending on the context-->
                <asp:Button ID="btnDeleteConfirm" runat="server" Text="Confirm Delete" Visible ="false" OnClick="btnDeleteConfirm_Click" /> <!--Deletes the product and makes deleteBtn visible, and makes  btnDeleteConfirm and btnDeleteCancel not visible-->
                <asp:Button ID="btnDeleteCancel" runat="server" Text="Cancel Delete"  Visible ="false" OnClick="btnDeleteCancel_Click" CausesValidation="False" /><!--Makes deleteBtn visible, and makes  btnDeleteConfirm and btnDeleteCancel not visible-->
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CausesValidation="False" /> <!--On click becomes invisible and makes btnDeleteConfirm and btnDeleteCancel visible-->
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnAddtoDB" runat="server" Text="Add" OnClick="btnAddtoDB_Click" />

                <asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClick="Button1_Click" Text="Cancel" />

            </div>
        </div>
    </div>
</asp:Content>
