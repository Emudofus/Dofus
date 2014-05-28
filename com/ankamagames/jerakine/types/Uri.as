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
      
      public function Uri(uri:String = null, secureMode:Boolean = true) {
         super();
         this._secureMode = secureMode;
         if((uri) && (uri.length > 0))
         {
            this.parseUri(uri);
         }
         MEMORY_LOG[this] = 1;
      }
      
      protected static const _log:Logger;
      
      public static var MEMORY_LOG:Dictionary;
      
      private static const URI_SYNTAX:RegExp;
      
      private static var _useSecureURI:Boolean = false;
      
      public static var _osIsWindows:Boolean;
      
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
      
      public function set protocol(value:String) : void {
         this._protocol = value;
         this._sum = "";
      }
      
      public function get path() : String {
         var path:String = null;
         if(_osIsWindows)
         {
            return this._path;
         }
         if((this._path.charAt(0) == "/") && (!(this._path.charAt(1) == "/")))
         {
            return "/" + this._path;
         }
         return this._path;
      }
      
      public function set path(value:String) : void {
         this._path = value.replace(new RegExp("\\\\","g"),"/");
         if(_osIsWindows)
         {
            this._path = this._path.replace(new RegExp("^\\/(\\/*)"),"\\\\");
         }
         this._sum = "";
      }
      
      public function get subPath() : String {
         return this._subpath;
      }
      
      public function set subPath(value:String) : void {
         this._subpath = value.substr(0,1) == "/"?value.substr(1):value;
         this._sum = "";
      }
      
      public function get uri() : String {
         return this.toString();
      }
      
      public function set uri(value:String) : void {
         this.parseUri(value);
      }
      
      public function get tag() : * {
         return this._tag;
      }
      
      public function set tag(value:*) : void {
         this._tag = value;
      }
      
      public function get loaderContext() : LoaderContext {
         return this._loaderContext;
      }
      
      public function set loaderContext(value:LoaderContext) : void {
         this._loaderContext = value;
      }
      
      public function get fileType() : String {
         var pointPos:* = 0;
         var paramPos:* = 0;
         if((!this._subpath) || (this._subpath.length == 0) || (this._subpath.indexOf(".") == -1))
         {
            pointPos = this._path.lastIndexOf(".");
            paramPos = this._path.indexOf("?");
            return this._path.substr(pointPos + 1,!(paramPos == -1)?paramPos - pointPos - 1:int.MAX_VALUE);
         }
         return this._subpath.substr(this._subpath.lastIndexOf(".") + 1,!(this._subpath.indexOf("?") == -1)?this._subpath.indexOf("?"):int.MAX_VALUE);
      }
      
      public function get fileName() : String {
         if((!this._subpath) || (this._subpath.length == 0))
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
         var dofusNativePath:String = null;
         var currentFile:File = null;
         var stack:String = null;
         try
         {
            dofusNativePath = unescape(File.applicationDirectory.nativePath);
            currentFile = File.applicationDirectory.resolvePath(unescape(this._path));
            stack = dofusNativePath;
            while(unescape(currentFile.nativePath) != dofusNativePath)
            {
               currentFile = currentFile.parent;
               if(currentFile)
               {
                  stack = stack + (" -> " + unescape(currentFile.nativePath));
                  continue;
               }
            }
            return true;
         }
         catch(e:Error)
         {
         }
         _log.debug("URI not secure : " + dofusNativePath);
         _log.debug("Détails : " + stack);
         return false;
      }
      
      public function toString(withSubPath:Boolean = true) : String {
         return this._protocol + "://" + this.path + ((withSubPath) && (this._subpath) && (this._subpath.length > 0)?"|" + this._subpath:"");
      }
      
      public function toSum() : String {
         if(this._sum.length > 0)
         {
            return this._sum;
         }
         var crc:CRC32 = new CRC32();
         var buf:ByteArray = new ByteArray();
         buf.writeUTF(this.normalizedUri);
         crc.update(buf);
         return this._sum = crc.getValue().toString(16);
      }
      
      public function toFile() : File {
         var tmp:String = unescape(this._path);
         if((SystemManager.getSingleton().os == OperatingSystem.WINDOWS) && ((tmp.indexOf("\\\\") == 0) || (tmp.charAt(1) == ":")))
         {
            return new File(tmp);
         }
         if((!(SystemManager.getSingleton().os == OperatingSystem.WINDOWS)) && (tmp.charAt(0) == "/"))
         {
            return new File("/" + tmp);
         }
         return new File(File.applicationDirectory.nativePath + File.separator + tmp);
      }
      
      private function parseUri(uri:String) : void {
         var m:Array = uri.match(URI_SYNTAX);
         if(!m)
         {
            throw new ArgumentError("\'" + uri + "\' is a misformated URI.");
         }
         else
         {
            this._protocol = m["protocol"];
            if(this._protocol.length == 0)
            {
               this._protocol = "file";
            }
            if(SystemManager.getSingleton().os == OperatingSystem.WINDOWS)
            {
               this.path = m["path"].replace(new RegExp("^\\/*"),"");
               this.path = this.path.replace("//","/");
            }
            else
            {
               this.path = m["path"];
            }
            if((this._secureMode) && (_useSecureURI) && (this._protocol == "file"))
            {
               if((AirScanner.hasAir()) && (!this.isSecure()) && (!(this._path.indexOf("\\\\") == 0)) && (this._path.indexOf("Dofus 2 Local") == -1) && (this._path.indexOf("core-resources") == -1))
               {
                  throw new ArgumentError("\'" + uri + "\' is a unsecure URI.");
               }
            }
            this._subpath = m["subpath"];
            this._sum = "";
            return;
         }
      }
      
      private function replaceChar(str:String, search:String, replace:String) : String {
         return str.split(search).join(replace);
      }
   }
}
