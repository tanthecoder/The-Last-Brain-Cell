<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="Ordered.aspx.cs" Inherits="IdeaShop.Ordered" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><asp:Label ID="lblTop" runat="server" Text="Your Order"></asp:Label><small> <%=DateTime.Now %></small></h2>
        <hr />
    <div  id ="checkoutCrumb" runat ="server">Cart >Edit Info >  Shipping Address > Payment > Comfirmation ><span class ="justRed"> Ordered!</span></div>
        <div>
        <asp:GridView ID="grdCartItems" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField HeaderText="Product ID" DataField="Product ID" />
                <asp:BoundField HeaderText="Product Name" DataField="Product Name" />
                <asp:BoundField HeaderText="Quantity" DataField="qty" />
                <asp:BoundField HeaderText="Price" DataField="HistoricalPrice" DataFormatString="{0:c}" />
                
                <asp:BoundField DataField="SubTotal" HeaderText="SubTotal" DataFormatString="{0:c}" />
                
            </Columns>
        </asp:GridView>
    </div>
    <div class ="col-md-12">
         <h3>Address: <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label></h3>
        <h3>Payment Type: <asp:Label ID="lblPayment" runat="server" Text=""></asp:Label></h3>
        <hr />
        <h3>Subtotal: <asp:Label ID="lblSubtotal" runat="server" Text=""></asp:Label></h3>
        <h3>Tax: <asp:Label ID="lblTax" runat="server" Text=""></asp:Label></h3>
        <h3>Shipping: <asp:Label ID="lblShipping" runat="server" Text=""></asp:Label></h3>
        <hr />
        <h3>Total: <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></h3>
    </div>
</asp:Content>
