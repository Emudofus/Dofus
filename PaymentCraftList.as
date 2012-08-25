package 
{

    class PaymentCraftList extends Object
    {
        public var kamaPaymentOnlySuccess:uint;
        public var objectsPaymentOnlySuccess:Array;
        public var kamaPayment:uint;
        public var objectsPayment:Array;

        function PaymentCraftList() : void
        {
            this.kamaPaymentOnlySuccess = 0;
            this.objectsPaymentOnlySuccess = new Array();
            this.kamaPayment = 0;
            this.objectsPayment = new Array();
            return;
        }// end function

    }
}
