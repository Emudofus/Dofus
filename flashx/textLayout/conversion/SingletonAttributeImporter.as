package flashx.textLayout.conversion
{


   class SingletonAttributeImporter extends Object implements IFormatImporter
   {
         

      function SingletonAttributeImporter(key:String) {
         super();
         this._keyToMatch=key;
      }



      private var _keyToMatch:String;

      private var _rslt:String = null;

      public function reset() : void {
         this._rslt=null;
      }

      public function get result() : Object {
         return this._rslt;
      }

      public function importOneFormat(key:String, val:String) : Boolean {
         if(key==this._keyToMatch)
         {
            this._rslt=val;
            return true;
         }
         return false;
      }
   }

}