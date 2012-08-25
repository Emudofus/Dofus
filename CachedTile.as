package 
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.types.*;

    class CachedTile extends Object
    {
        public var uriName:String;
        public var clipName:String;
        private var _list:Vector.<ZoneClipTile>;

        function CachedTile(param1:String, param2:String) : void
        {
            this.uriName = param1;
            this.clipName = param2;
            this._list = new Vector.<ZoneClipTile>;
            return;
        }// end function

        public function push(param1:ZoneClipTile) : void
        {
            this._list.push(param1);
            return;
        }// end function

        public function shift() : ZoneClipTile
        {
            return this._list.shift();
        }// end function

        public function get length() : uint
        {
            return this._list.length;
        }// end function

    }
}
