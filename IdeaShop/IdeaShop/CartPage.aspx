<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="CartPage.aspx.cs" Inherits="IdeaShop.CartPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>
        <asp:Label ID="lblTop" runat="server" Text="Your Shopping Cart"></asp:Label><small> <%=DateTime.Now %></small></h2>
    <hr />
    <div id="checkoutCrumb" runat="server"><span class="justRed">Cart</span> > Edit Info > Shipping Address > Payment > Comfirmation > Ordered!</div>

    <div>
        <asp:GridView ID="grdCartItems" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Product ID" DataField="Product ID" />
                <asp:BoundField HeaderText="Product Name" DataField="Product Name" />
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:TextBox TextMode="Number" ID="Quantity" runat="server" MaxLength="3" Text='<%# Eval("qty")%>' Width="40px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Subtotal">
                    <ItemTemplate>
                        <asp:Label ID="lblSubtotal" runat="server" Text='<%# Eval("SubTotal", "{0:c}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remove">
                    <ItemTemplate>
                        <asp:CheckBox id="chkRemove" DataField="Remove" runat="server" AutoPostBack="true"/>
                    </ItemTemplate>
                </asp:TemplateField>
                
            </Columns>
        </asp:GridView>
    </div>
    <div class="col-md-8">
        
        
        <h3>Subtotal:
            <asp:Label ID="lblSubtotal" runat="server" Text=""></asp:Label></h3>
        <h3>Tax:
            <asp:Label ID="lblTax" runat="server" Text=""></asp:Label></h3>
        <h3>Shipping:
            <asp:Label ID="lblShipping" runat="server" Text=""></asp:Label></h3>
        <hr />
        <h3>Total:
            <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></h3>
        

    </div>
    <div class="col-md-4">
        
        <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
        <asp:Button ID="btnCheckout" runat="server" Text="Check Out" OnClick="btnCheckout_Click" />
        
    </div>

</asp:Content>
