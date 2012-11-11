package mx.core
{

    public interface ILayoutDirectionElement
    {

        public function ILayoutDirectionElement();

        function get layoutDirection() : String;

        function set layoutDirection(param1:String) : void;

        function invalidateLayoutDirection() : void;

    }
}
