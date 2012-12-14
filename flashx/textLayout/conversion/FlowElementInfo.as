package flashx.textLayout.conversion
{
    import flash.utils.*;

    class FlowElementInfo extends Object
    {
        private var _flowClass:Class;
        private var _flowClassName:String;
        private var _parser:Function;
        private var _exporter:Function;

        function FlowElementInfo(param1:Class, param2:Function, param3:Function)
        {
            this._flowClass = param1;
            this._parser = param2;
            this._exporter = param3;
            this._flowClassName = getQualifiedClassName(param1);
            return;
        }// end function

        public function get flowClass() : Class
        {
            return this._flowClass;
        }// end function

        public function get flowClassName() : String
        {
            return this._flowClassName;
        }// end function

        public function get parser() : Function
        {
            return this._parser;
        }// end function

        public function get exporter() : Function
        {
            return this._exporter;
        }// end function

    }
}
