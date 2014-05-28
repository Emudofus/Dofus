package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public class CSystemBridge extends Object implements CSystem
   {
      
      public function CSystemBridge(param1:String, param2:int) {
         this.curPackBuf = new LEByteArray();
         this.handlers = {};
         this.requests = {};
         super();
         this.sock = new Socket();
         this.sock.endian = "littleEndian";
         this.sock.addEventListener(Event.CONNECT,this.sockConnect);
         this.sock.addEventListener(ProgressEvent.SOCKET_DATA,this.sockData);
         this.sock.addEventListener(IOErrorEvent.IO_ERROR,this.sockError);
         this.sock.connect(param1,param2);
      }
      
      static const TELL:int = 9;
      
      static const ACCESS:int = 3;
      
      static const EXIT:int = 10;
      
      static const FSIZE:int = 1;
      
      static const OPEN:int = 4;
      
      static const LSEEK:int = 8;
      
      static const PSIZE:int = 2;
      
      static const READ:int = 7;
      
      static const CLOSE:int = 5;
      
      static const SETUP:int = 11;
      
      static const WRITE:int = 6;
      
      public function psize(param1:int) : int {
         var p:int = param1;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(PSIZE);
            param1.writeUTFBytes(CSystemBridge.gworker.stringFromPtr(p));
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
      
      private function asyncReq(param1:Function, param2:Function) : * {
         var rid:String = null;
         var req:Object = null;
         var pack:ByteArray = null;
         var create:Function = param1;
         var handle:Function = param2;
         rid = String(CSystemBridge.esp);
         req = this.requests[rid];
         if(req)
         {
            if(req.pending)
            {
               throw new AlchemyBlock();
            }
            else
            {
               delete this.requests[[rid]];
               return req.result;
            }
         }
         else
         {
            req = {"pending":true};
            this.requests[rid] = req;
            pack = new LEByteArray();
            create(pack);
            this.sendRequest(pack,function(param1:ByteArray):void
            {
               req.result = handle(param1);
               req.pending = false;
            });
            if(req.pending)
            {
               throw new AlchemyBlock();
            }
            else
            {
               return;
            }
         }
      }
      
      public function setup(param1:Function) : void {
         var pack:ByteArray = null;
         var f:Function = param1;
         pack = new LEByteArray();
         pack.writeInt(SETUP);
         this.sendRequest(pack,function(param1:ByteArray):void
         {
            var _loc4_:Array = null;
            var _loc2_:int = param1.readInt();
            argv = [];
            while(_loc2_--)
            {
               argv.push(param1.readUTF());
            }
            var _loc3_:int = param1.readInt();
            env = {};
            while(_loc3_--)
            {
               _loc4_ = new RegExp("([^\\=]*)\\=(.*)").exec(param1.readUTF());
               if((_loc4_) && _loc4_.length == 3)
               {
                  env[_loc4_[1]] = _loc4_[2];
               }
            }
            f();
         });
      }
      
      private function sockConnect(param1:Event) : void {
         log(2,"bridge connected");
      }
      
      private function sockData(param1:ProgressEvent) : void {
         var _loc2_:* = 0;
         while(this.sock.bytesAvailable)
         {
            if(!this.curPackLen)
            {
               if(this.sock.bytesAvailable >= 8)
               {
                  this.curPackId = this.sock.readInt();
                  this.curPackLen = this.sock.readInt();
                  log(3,"bridge packet id: " + this.curPackId + " len: " + this.curPackLen);
                  this.curPackBuf.length = this.curPackLen;
                  this.curPackBuf.position = 0;
                  continue;
               }
               break;
            }
            _loc2_ = this.sock.bytesAvailable;
            if(_loc2_ > this.curPackLen)
            {
               _loc2_ = this.curPackLen;
            }
            this.curPackLen = this.curPackLen - _loc2_;
            while(_loc2_--)
            {
               this.curPackBuf.writeByte(this.sock.readByte());
            }
            if(!this.curPackLen)
            {
               this.handlePacket();
            }
         }
      }
      
      public function read(param1:int, param2:int, param3:int) : int {
         var fd:int = param1;
         var buf:int = param2;
         var nbytes:int = param3;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(READ);
            param1.writeInt(fd);
            param1.writeInt(nbytes);
         },function(param1:ByteArray):int
         {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            _loc2_ = param1.readInt();
            _loc3_ = "";
            CSystemBridge.ds.position = buf;
            while(param1.bytesAvailable)
            {
               _loc4_ = param1.readByte();
               _loc3_ = _loc3_ + String.fromCharCode(_loc4_);
               CSystemBridge.ds.writeByte(_loc4_);
            }
            log(4,"read from: " + fd + " : [" + _loc3_ + "]");
            return _loc2_;
         });
      }
      
      public function exit(param1:int) : void {
         var _loc2_:ByteArray = null;
         _loc2_ = new LEByteArray();
         _loc2_.writeInt(EXIT);
         _loc2_.writeInt(param1);
         this.sendRequest(_loc2_,null);
         shellExit(param1);
      }
      
      private function sockError(param1:IOErrorEvent) : void {
         log(2,"bridge error");
      }
      
      public function tell(param1:int) : int {
         var fd:int = param1;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(TELL);
            param1.writeInt(fd);
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
      
      private var curPackBuf:ByteArray;
      
      public function ioctl(param1:int, param2:int, param3:int) : int {
         return -1;
      }
      
      public function getargv() : Array {
         return this.argv;
      }
      
      private var sock:Socket;
      
      public function open(param1:int, param2:int, param3:int) : int {
         var path:int = param1;
         var flags:int = param2;
         var mode:int = param3;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(OPEN);
            param1.writeInt(flags);
            param1.writeInt(mode);
            param1.writeUTFBytes(CSystemBridge.gworker.stringFromPtr(path));
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
      
      private var requests:Object;
      
      private var sentPackId:int = 1;
      
      private function handlePacket() : void {
         this.curPackBuf.position = 0;
         this.handlers[this.curPackId](this.curPackBuf);
         if(this.curPackId)
         {
            delete this.handlers[[this.curPackId]];
         }
      }
      
      public function getenv() : Object {
         return this.env;
      }
      
      private var curPackLen:int;
      
      public function write(param1:int, param2:int, param3:int) : int {
         var fd:int = param1;
         var buf:int = param2;
         var nbytes:int = param3;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(WRITE);
            param1.writeInt(fd);
            if(nbytes > 4096)
            {
               nbytes = 4096;
            }
            param1.writeBytes(CSystemBridge.ds,buf,nbytes);
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
      
      var argv:Array;
      
      private function sendRequest(param1:ByteArray, param2:Function) : void {
         if(param2)
         {
            this.handlers[this.sentPackId] = param2;
         }
         this.sock.writeInt(this.sentPackId);
         this.sock.writeInt(param1.length);
         this.sock.writeBytes(param1,0);
         this.sock.flush();
         this.sentPackId++;
      }
      
      private var handlers:Object;
      
      public function lseek(param1:int, param2:int, param3:int) : int {
         var fd:int = param1;
         var offset:int = param2;
         var whence:int = param3;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(LSEEK);
            param1.writeInt(fd);
            param1.writeInt(offset);
            param1.writeInt(whence);
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
      
      var env:Object;
      
      public function fsize(param1:int) : int {
         var fd:int = param1;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(FSIZE);
            param1.writeInt(fd);
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
      
      public function access(param1:int, param2:int) : int {
         var path:int = param1;
         var mode:int = param2;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(ACCESS);
            param1.writeInt(mode);
            param1.writeUTFBytes(CSystemBridge.gworker.stringFromPtr(path));
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
      
      private var curPackId:int;
      
      public function close(param1:int) : int {
         var fd:int = param1;
         return this.asyncReq(function(param1:ByteArray):void
         {
            param1.writeInt(CLOSE);
            param1.writeInt(fd);
         },function(param1:ByteArray):int
         {
            return param1.readInt();
         });
      }
   }
}
