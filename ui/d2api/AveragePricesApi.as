package d2api
{
    public class AveragePricesApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Trusted]
        public function getItemAveragePrice(pItemId:uint):int
        {
            return (0);
        }

        [Trusted]
        public function getItemAveragePriceString(pItem:*, pAddLineBreakBefore:Boolean=false):String
        {
            return (null);
        }

        [Trusted]
        public function dataAvailable():Boolean
        {
            return (false);
        }


    }
}//package d2api

