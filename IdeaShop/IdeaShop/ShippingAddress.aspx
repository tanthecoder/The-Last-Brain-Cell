<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="ShippingAddress.aspx.cs" Inherits="IdeaShop.ShippingAddress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><asp:Label ID="lblTop" runat="server" Text="Your Shopping Cart"></asp:Label><small> <%=DateTime.Now %></small></h2>
        <hr />
    <div  id ="checkoutCrumb" runat ="server">Cart >Edit Info ><span class ="justRed">  Shipping Address</span> > Payment > Comfirmation > Ordered!</div>
<div>
              
             <h4 class ="checkoutAddress"><asp:Button ID="btnMyAddress" runat="server" Text="Use My Address" OnClick="btnMyAddress_Click" CausesValidation="False" /></h4>
              
             <div class ="checkoutAddress">
            <h5>Country</h5>
             <asp:DropDownList ID="country" runat="server" AutoPostBack="true">
                 <asp:ListItem Text ="United States" Value ="United States" Selected="True"></asp:ListItem>
                 <asp:ListItem Text ="Canada" Value ="Canada"></asp:ListItem>
                 <asp:ListItem Text ="Uganda" Value ="Uganda"></asp:ListItem>
             </asp:DropDownList>
             <h5>City</h5>
            <asp:TextBox ID="city" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="city" ID="RequiredFieldValidator8" class ="justRed" runat="server" ErrorMessage="City Required" ></asp:RequiredFieldValidator>
            <h5>State/Province</h5>
            <asp:TextBox ID="sOrP" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="sOrP" ID="RequiredFieldValidator9" class ="justRed" runat="server" ErrorMessage="State Or Province Required" ></asp:RequiredFieldValidator>
             <h5>Street Address</h5>
            <asp:TextBox ID="address" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="address" ID="RequiredFieldValidator10" class ="justRed" runat="server" ErrorMessage="Street Address Required" ></asp:RequiredFieldValidator>
            <h5>Zip Code</h5>
            <asp:TextBox ID="zip" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="zip" ID="RequiredFieldValidator11" runat="server" ErrorMessage="zipcode required" ></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ControlToValidate="zip" ID="regexZip" class ="justRed" runat="server" ErrorMessage="Invalid Zipcode" ValidationExpression="(?:[^\d]|^)(\d{5}\-\d{4})(?:[^\d]|$)|[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ] ?[0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]"></asp:RegularExpressionValidator>

        </div>
        <div class ="checkoutAddress">
            <asp:Button ID="btnContinue" runat="server" Text="Continue" OnClick="btnContinue_Click" />
        </div>
</div>
</asp:Content>
