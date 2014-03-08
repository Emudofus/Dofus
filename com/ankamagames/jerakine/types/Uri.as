package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import flash.system.LoaderContext;
   import flash.errors.IllegalOperationError;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   
   public class Uri extends Object
   {
      
      public function Uri(param1:String=null, param2:Boolean=true) {
         super();
         this._secureMode = param2;
         if((param1) && param1.length > 0)
         {
            this.parseUri(param1);
         }
         MEMORY_LOG[this] = 1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Uri));
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private static const URI_SYNTAX:RegExp = new RegExp("^(?:(?P<protocol>[a-z0-9]+)\\:\\/\\/)*(?P<path>[^\\|]*)(?|\\|)?(?|\\/)?(?P<subpath>.*)?$","i");
      
      private static var _useSecureURI:Boolean = false;
      
      public static var _osIsWindows:Boolean = SystemManager.getSingleton().os == OperatingSystem.WINDOWS;
      
      public static function enableSecureURI() : void {
         _useSecureURI = true;
      }
      
      private var _protocol:String;
      
      private var _path:String;
      
      private var _subpath:String;
      
      private var _tag;
      
      private var _sum:String;
      
      private var _loaderContext:LoaderContext;
      
      private var _secureMode:Boolean;
      
      public function get protocol() : String {
         return this._protocol;
      }
      
      public function set protocol(param1:String) : void {
         this._protocol = param1;
         this._sum = "";
      }
      
      public function get path() : String {
         var _loc1_:String = null;
         if(_osIsWindows)
         {
            return this._path;
         }
         if(this._path.charAt(0) == "/" && !(this._path.charAt(1) == "/"))
         {
            return "/" + this._path;
         }
         return this._path;
      }
      
      public function set path(param1:String) : void {
         this._path = param1.replace(new RegExp("\\\\","g"),"/");
         if(_osIsWindows)
         {
            this._path = this._path.replace(new RegExp("^\\/(\\/*)"),"\\\\");
         }
         this._sum = "";
      }
      
      public function get subPath() : String {
         return this._subpath;
      }
      
      public function set subPath(param1:String) : void {
         this._subpath = param1.substr(0,1) == "/"?param1.substr(1):param1;
         this._sum = "";
      }
      
      public function get uri() : String {
         return this.toString();
      }
      
      public function set uri(param1:String) : void {
         this.parseUri(param1);
      }
      
      public function get tag() : * {
         return this._tag;
      }
      
      public function set tag(param1:*) : void {
         this._tag = param1;
      }
      
      public function get loaderContext() : LoaderContext {
         return this._loaderContext;
      }
      
      public function set loaderContext(param1:LoaderContext) : void {
         this._loaderContext = param1;
      }
      
      public function get fileType() : String {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(!this._subpath || this._subpath.length == 0 || this._subpath.indexOf(".") == -1)
         {
            _loc1_ = this._path.lastIndexOf(".");
            _loc2_ = this._path.indexOf("?");
            return this._path.substr(_loc1_ + 1,_loc2_ != -1?_loc2_ - _loc1_-1:int.MAX_VALUE);
         }
         return this._subpath.substr(this._subpath.lastIndexOf(".") + 1,this._subpath.indexOf("?") != -1?this._subpath.indexOf("?"):int.MAX_VALUE);
      }
      
      public function get fileName() : String {
         if(!this._subpath || this._subpath.length == 0)
         {
            return this._path.substr(this._path.lastIndexOf("/") + 1);
         }
         return this._subpath.substr(this._subpath.lastIndexOf("/") + 1);
      }
      
      public function get normalizedUri() : String {
         switch(this._protocol)
         {
            case "http":
            case "https":
            case "httpc":
            case "file":
            case "zip":
            case "upd":
            case "mod":
            case "theme":
            case "d2p":
            case "d2pOld":
            case "pak":
            case "pak2":
               return this.replaceChar(this.uri,"\\","/");
            default:
               throw new IllegalOperationError("Unsupported protocol " + this._protocol + " for normalization.");
         }
      }
      
      public function get normalizedUriWithoutSubPath() : String {
         switch(this._protocol)
         {
            case "http":
            case "https":
            case "httpc":
            case "file":
            case "zip":
            case "upd":
            case "mod":
            case "theme":
            case "d2p":
            case "d2pOld":
            case "pak":
            case "pak2":
               return this.replaceChar(this.toString(false),"\\","/");
            default:
               throw new IllegalOperationError("Unsupported protocol " + this._protocol + " for normalization.");
         }
      }
      
      public function isSecure() : Boolean {
         var _loc1_:String = null;
         var _loc2_:File = null;
         var _loc3_:String = null;
         try
         {
            _loc1_ = unescape(File.applicationDirectory.nativePath);
            _loc2_ = File.applicationDirectory.resolvePath(unescape(this._path));
            _loc3_ = _loc1_;
            while(unescape(_loc2_.nativePath) != _loc1_)
            {
               _loc2_ = _loc2_.parent;
               if(_loc2_)
               {
                  _loc3_ = _loc3_ + (" -> " + unescape(_loc2_.nativePath));
                  continue;
               }
            }
            return true;
         }
         catch(e:Error)
         {
         }
         _log.debug("URI not secure : " + _loc1_);
         _log.debug("Détails : " + _loc3_);
         return false;
      }
      
      public function toString(param1:Boolean=true) : String {
         return this._protocol + "://" + this.path + ((param1) && (this._subpath) && this._subpath.length > 0?"|" + this._subpath:"");
      }
      
      public function toSum() : String {
         if(this._sum.length > 0)
         {
            return this._sum;
         }
         var _loc1_:CRC32 = new CRC32();
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTF(this.normalizedUri);
         _loc1_.update(_loc2_);
         return this._sum = _loc1_.getValue().toString(16);
      }
      
      public function toFile() : File {
         var _loc1_:String = unescape(this._path);
         if(SystemManager.getSingleton().os == OperatingSystem.WINDOWS && (_loc1_.indexOf("\\\\") == 0 || _loc1_.charAt(1) == ":"))
         {
            return new File(_loc1_);
         }
         if(!(SystemManager.getSingleton().os == OperatingSystem.WINDOWS) && _loc1_.charAt(0) == "/")
         {
            return new File("/" + _loc1_);
         }
         return new File(File.applicationDirectory.nativePath + File.separator + _loc1_);
      }
      
      private function parseUri(param1:String) : void {
         var _loc2_:Array = param1.match(URI_SYNTAX);
         if(!_loc2_)
         {
            throw new ArgumentError("\'" + param1 + "\' is a misformated URI.");
         }
         else
         {
            this._protocol = _loc2_["protocol"];
            if(this._protocol.length == 0)
            {
               this._protocol = "file";
            }
            if(SystemManager.getSingleton().os == OperatingSystem.WINDOWS)
            {
               this.path = _loc2_["path"].replace(new RegExp("^\\/*"),"");
               this.path = this.path.replace("//","/");
            }
            else
            {
               this.path = _loc2_["path"];
            }
            if((this._secureMode) && (_useSecureURI) && this._protocol == "file")
            {
               if((AirScanner.hasAir()) && !this.isSecure() && !(this._path.indexOf("\\\\") == 0) && this._path.indexOf("Dofus 2 Local") == -1 && this._path.indexOf("core-resources") == -1)
               {
                  throw new ArgumentError("\'" + param1 + "\' is a unsecure URI.");
               }
            }
            this._subpath = _loc2_["subpath"];
            this._sum = "";
            return;
         }
      }
      
      private function replaceChar(param1:String, param2:String, param3:String) : String {
         return param1.split(param2).join(param3);
      }
   }
}
