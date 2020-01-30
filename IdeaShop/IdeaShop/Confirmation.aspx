<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="IdeaShop.Confirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h2><asp:Label ID="lblTop" runat="server" Text="Review Your Order"></asp:Label><small> <%=DateTime.Now %></small></h2>
        <hr />
    <div  id ="checkoutCrumb" runat ="server">Cart >Edit Info >  Shipping Address > Payment ><span class ="justRed"> Comfirmation </span>> Ordered!</div>
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
    <div class ="col-md-8">
        <h3>Address: <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label></h3>
        <h3>Payment Type: <asp:Label ID="lblPayment" runat="server" Text=""></asp:Label></h3>
        <hr />
        <h3>Subtotal: <asp:Label ID="lblSubtotal" runat="server" Text=""></asp:Label></h3>
        <h3>Tax: <asp:Label ID="lblTax" runat="server" Text=""></asp:Label></h3>
        <h3>Shipping: <asp:Label ID="lblShipping" runat="server" Text=""></asp:Label></h3>
        <hr />
        <h3>Total: <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></h3>
    </div>
    <div class ="col-md-4">
        <asp:Button ID="btnConfirm" runat="server" Text="CONFIRM ORDER" OnClick="btnConfirm_Click" /></br>
        <asp:Button ID="btnCart" runat="server" Text="Back to Cart" OnClick="btnCart_Click" />

    </div>
</asp:Content>
