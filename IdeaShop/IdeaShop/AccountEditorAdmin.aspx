<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="AccountEditorAdmin.aspx.cs" Inherits="IdeaShop.AccountEditorAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="MyStyles/Editor.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div>
        <h2><asp:Label ID="lblTop" runat="server" Text=""></asp:Label><small> <%=DateTime.Now %></small></h2>
        <hr />
        <div>
            <h5>Search Users</h5>
            <asp:DropDownList ID="customers" runat="server"></asp:DropDownList>
            <asp:Button ID="btnLoadCustomer" runat="server" Text="Load" CausesValidation ="False" OnClick="btnLoadCustomer_Click" />
            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" class ="glyphicon glyphicon-eye-open" CausesValidation ="False" OnClick="btnSearch_Click"/>
        </div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        <div runat ="server" id ="editBox" >
        <div class ="col-md-6" runat="server" id="whereAllThingsAreIn">
            <h3><small>Id: <asp:Label ID="lblID" runat="server" Text="Label"></asp:Label></small></h3>
             <h5>Username</h5>
            <asp:TextBox ID="username" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="username" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Username Required" class ="justRed"></asp:RequiredFieldValidator>
            <!--h5>Password<h5-->
            <asp:TextBox ID="password" runat="server" TextMode="Password" Visible="False"></asp:TextBox>
            <h5 style="display:none;">Confirm Password</h5>
            <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password" Visible="false"></asp:TextBox>
            <%--<asp:RequiredFieldValidator ControlToValidate="confirmPassword" ID="RequiredFieldValidator3" runat="server" ErrorMessage="RequiredFieldValidator" ></asp:RequiredFieldValidator>--%>
             <h5>Email</h5>
            <asp:TextBox ID="email" runat="server" TextMode ="email"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="email" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Email Required" class ="justRed"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="email" runat="server" ErrorMessage="Incorrect Email Format" ValidationExpression="(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|&quot;(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*&quot;)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])" class ="justRed"></asp:RegularExpressionValidator>
            <!--Source: https://emailregex.com/-->
            <h5>Phone Number</h5>
            <asp:TextBox ID="phone" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="phone" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Phone number required" class ="justRed"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Incorrect phone number format" ControlToValidate="phone" ValidationExpression="^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$" class ="justRed"></asp:RegularExpressionValidator>
            <!--Source: https://regexr.com/3c53v -->
            <hr />
            <asp:Label ID="lblContactAdmin" runat="server" Text="If you want to edit your names, please contact an admin."></asp:Label>
            <h5>First Name</h5>
            <asp:TextBox ID="fname" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="fname" ID="RequiredFieldValidator6" runat="server" ErrorMessage="First Name Required" class ="justRed"></asp:RequiredFieldValidator>
            <h5>Middle Name</h5>
            <asp:TextBox ID="mname" runat="server"></asp:TextBox>
           <h5>Last Name</h5>
            <asp:TextBox ID="lname" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="lname" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Last Name Required" class ="justRed"></asp:RequiredFieldValidator>
            <h5>Birthdate</h5>
            <input type ="date" runat="server" id ="birthDate" disabled="disabled" />

        </div>
        
         <div class ="col-md-6" runat="server" id="addressDiv">
           <h5>Country</h5>
             <asp:DropDownList ID="country" runat="server" AutoPostBack ="True" OnSelectedIndexChanged="changeRegex">
                 <asp:ListItem Text ="United States" Value ="United States" Selected="True"></asp:ListItem>
                 <asp:ListItem Text ="Canada" Value ="Canada"></asp:ListItem>
                 <asp:ListItem Text ="Uganda" Value ="Uganda"></asp:ListItem>
             </asp:DropDownList><span>*</span>
             <h5>City</h5>
            <asp:TextBox ID="city" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="city" ID="RequiredFieldValidator8" runat="server" ErrorMessage="City Required" class ="justRed"></asp:RequiredFieldValidator>
            <h5>State/Province</h5>
            <asp:TextBox ID="sOrP" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="sOrP" ID="RequiredFieldValidator9" runat="server" ErrorMessage="State/Province Required" class ="justRed"></asp:RequiredFieldValidator>
             <h5>Street Address</h5>
            <asp:TextBox ID="address" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="address" ID="RequiredFieldValidator10" runat="server" ErrorMessage="Street Address Required" class ="justRed" ></asp:RequiredFieldValidator>
            <h5>Zip Code</h5>
            <asp:TextBox ID="zip" runat="server"></asp:TextBox><span>*</span>
            <asp:RequiredFieldValidator ControlToValidate="zip" ID="RequiredFieldValidator11" runat="server" ErrorMessage="Zip Code Required" class ="justRed"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ControlToValidate="zip" ID="regexZip" runat="server" ErrorMessage="Incorrect Zipcode Format" ValidationExpression="^\d{5}(?:[-\s]\d{4})?$" class ="justRed"></asp:RegularExpressionValidator>
             <hr />
             <asp:Button ID="btnArchive" runat="server" text ="Archive" OnClick="btnArchive_Click"/><br />
             <asp:Button ID="btnSave" runat="server" Text="Create Account" visible="false"/><br />
             <asp:Button ID="btnCancel" runat="server" Text="Cancel" visible="false"/>
        </div>
        </div>
    </div>
</asp:Content>


