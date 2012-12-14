package flashx.textLayout.conversion
{

    public class ImportExportConfiguration extends Object
    {
        var flowElementInfoList:Object;
        var flowElementClassList:Object;
        var classToNameMap:Object;

        public function ImportExportConfiguration()
        {
            this.flowElementInfoList = {};
            this.flowElementClassList = {};
            this.classToNameMap = {};
            return;
        }// end function

        public function addIEInfo(param1:String, param2:Class, param3:Function, param4:Function) : void
        {
            var _loc_5:* = new FlowElementInfo(param2, param3, param4);
            if (param1)
            {
                this.flowElementInfoList[param1] = _loc_5;
            }
            if (param2)
            {
                this.flowElementClassList[_loc_5.flowClassName] = _loc_5;
            }
            if (param1 && param2)
            {
                this.classToNameMap[_loc_5.flowClassName] = param1;
            }
            return;
        }// end function

        public function lookup(param1:String) : FlowElementInfo
        {
            return this.flowElementInfoList[param1];
        }// end function

        public function lookupName(param1:String) : String
        {
            return this.classToNameMap[param1];
        }// end function

        public function lookupByClass(param1:String) : FlowElementInfo
        {
            return this.flowElementClassList[param1];
        }// end function

    }
}
