package flashx.textLayout.elements
{
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class FlowValueHolder extends TextLayoutFormat
   {
      
      public function FlowValueHolder(param1:FlowValueHolder=null) {
         super(param1);
         this.initialize(param1);
      }
      
      private var _privateData:Object;
      
      private function initialize(param1:FlowValueHolder) : void {
         var _loc2_:String = null;
         if(param1)
         {
            for (_loc2_ in param1.privateData)
            {
               this.setPrivateData(_loc2_,param1.privateData[_loc2_]);
            }
         }
      }
      
      public function get privateData() : Object {
         return this._privateData;
      }
      
      public function set privateData(param1:Object) : void {
         this._privateData = param1;
      }
      
      public function getPrivateData(param1:String) : * {
         return this._privateData?this._privateData[param1]:undefined;
      }
      
      public function setPrivateData(param1:String, param2:*) : void {
         if(param2 === undefined)
         {
            if(this._privateData)
            {
               delete this._privateData[[param1]];
            }
         }
         else
         {
            if(this._privateData == null)
            {
               this._privateData = {};
            }
            this._privateData[param1] = param2;
         }
      }
   }
}
