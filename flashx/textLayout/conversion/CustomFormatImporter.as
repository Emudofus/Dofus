package flashx.textLayout.conversion
{
   import flash.utils.Dictionary;


   class CustomFormatImporter extends Object implements IFormatImporter
   {
         

      function CustomFormatImporter() {
         super();
      }



      private var _rslt:Dictionary = null;

      public function reset() : void {
         this._rslt=null;
      }

      public function get result() : Object {
         return this._rslt;
      }

      public function importOneFormat(key:String, val:String) : Boolean {
         if(this._rslt==null)
         {
            this._rslt=new Dictionary();
         }
         this._rslt[key]=val;
         return true;
      }
   }

}