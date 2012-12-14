package by.blooddy.crypto.image
{
    import flash.utils.*;

    final public class JPEGTable extends Object
    {
        private static const _quantTables:Array = new Array();
        private static var _jpegTable:ByteArray;

        public function JPEGTable()
        {
            Error.throwError(ArgumentError, 2012, getQualifiedClassName(this));
            return;
        }// end function

        public static function getTable(param1:uint = 60) : ByteArray
        {
            if (param1 > 100)
            {
                Error.throwError(RangeError, 2006, "quality");
            }
            if (param1 < 1)
            {
                param1 = 1;
            }
            var _loc_2:* = _quantTables[param1];
            if (!_loc_2)
            {
                _loc_2 = JPEGTableHelper.createQuantTable(param1);
                if (!_jpegTable)
                {
                    _jpegTable = new ByteArray();
                    _jpegTable.writeBytes(JPEGTableHelper.createZigZagTable());
                    _jpegTable.writeBytes(JPEGTableHelper.createHuffmanTable());
                    _jpegTable.writeBytes(JPEGTableHelper.createCategoryTable());
                }
            }
            var _loc_3:* = new ByteArray();
            _loc_3.writeBytes(_loc_2);
            _loc_3.writeBytes(_jpegTable);
            _loc_3.position = 0;
            return _loc_3;
        }// end function

    }
}
