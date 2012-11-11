package flashx.textLayout.elements
{
    import flashx.textLayout.formats.*;

    public class FlowValueHolder extends TextLayoutFormat
    {
        private var _privateData:Object;

        public function FlowValueHolder(param1:FlowValueHolder = null)
        {
            super(param1);
            this.initialize(param1);
            return;
        }// end function

        private function initialize(param1:FlowValueHolder) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                for (_loc_2 in param1.privateData)
                {
                    
                    this.setPrivateData(_loc_2, param1.privateData[_loc_2]);
                }
            }
            return;
        }// end function

        public function get privateData() : Object
        {
            return this._privateData;
        }// end function

        public function set privateData(param1:Object) : void
        {
            this._privateData = param1;
            return;
        }// end function

        public function getPrivateData(param1:String)
        {
            return this._privateData ? (this._privateData[param1]) : (undefined);
        }// end function

        public function setPrivateData(param1:String, param2) : void
        {
            if (param2 === undefined)
            {
                if (this._privateData)
                {
                    delete this._privateData[param1];
                }
            }
            else
            {
                if (this._privateData == null)
                {
                    this._privateData = {};
                }
                this._privateData[param1] = param2;
            }
            return;
        }// end function

    }
}
