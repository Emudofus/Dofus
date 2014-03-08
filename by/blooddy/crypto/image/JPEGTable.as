package by.blooddy.crypto.image
{
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public final class JPEGTable extends Object
   {
      
      public function JPEGTable() {
         super();
         Error.throwError(ArgumentError,2012,getQualifiedClassName(this));
      }
      
      private static const _quantTables:Array = new Array();
      
      private static var _jpegTable:ByteArray;
      
      public static function getTable(param1:uint=60) : ByteArray {
         if(param1 > 100)
         {
            Error.throwError(RangeError,2006,"quality");
         }
         if(param1 < 1)
         {
            param1 = 1;
         }
         var _loc2_:ByteArray = _quantTables[param1];
         if(!_loc2_)
         {
            _loc2_ = JPEGTableHelper.createQuantTable(param1);
            if(!_jpegTable)
            {
               _jpegTable = new ByteArray();
               _jpegTable.writeBytes(JPEGTableHelper.createZigZagTable());
               _jpegTable.writeBytes(JPEGTableHelper.createHuffmanTable());
               _jpegTable.writeBytes(JPEGTableHelper.createCategoryTable());
            }
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeBytes(_loc2_);
         _loc3_.writeBytes(_jpegTable);
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}
