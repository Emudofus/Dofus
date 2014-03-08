package cmodule.lua_wrapper
{
   import flash.utils.ByteArray;
   
   class ByteArrayIO extends IO
   {
      
      function ByteArrayIO() {
         super();
      }
      
      public var byteArray:ByteArray;
      
      override public function set size(param1:int) : void {
         if(!this.byteArray)
         {
            throw new AlchemyBlock();
         }
         else
         {
            this.byteArray.length = param1;
            return;
         }
      }
      
      override public function read(param1:int, param2:int) : int {
         var _loc3_:* = 0;
         if(!this.byteArray)
         {
            throw new AlchemyBlock();
         }
         else
         {
            _loc3_ = Math.min(param2,this.byteArray.bytesAvailable);
            if(_loc3_)
            {
               this.byteArray.readBytes(ByteArrayIO.ds,param1,_loc3_);
            }
            return _loc3_;
         }
      }
      
      override public function get size() : int {
         if(!this.byteArray)
         {
            throw new AlchemyBlock();
         }
         else
         {
            return this.byteArray.length;
         }
      }
      
      override public function get position() : int {
         if(!this.byteArray)
         {
            throw new AlchemyBlock();
         }
         else
         {
            return this.byteArray.position;
         }
      }
      
      override public function set position(param1:int) : void {
         if(!this.byteArray)
         {
            throw new AlchemyBlock();
         }
         else
         {
            this.byteArray.position = param1;
            return;
         }
      }
      
      override public function write(param1:int, param2:int) : int {
         if(!this.byteArray)
         {
            throw new AlchemyBlock();
         }
         else
         {
            if(param2)
            {
               this.byteArray.writeBytes(ByteArrayIO.ds,param1,param2);
            }
            return param2;
         }
      }
   }
}
