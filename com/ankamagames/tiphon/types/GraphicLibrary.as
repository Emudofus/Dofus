package com.ankamagames.tiphon.types
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.events.SwlEvent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.engine.BoneIndexManager;
   import com.ankamagames.tiphon.TiphonConstants;
   
   public class GraphicLibrary extends EventDispatcher
   {
      
      public function GraphicLibrary(pGfxId:uint, isBone:Boolean=false) {
         this._swl = new Dictionary();
         this._waitingSwl = new Dictionary();
         super();
         this.gfxId = pGfxId;
         this._isBone = isBone;
      }
      
      private var _swl:Dictionary;
      
      public var gfxId:uint;
      
      private var _swlCount:uint = 0;
      
      private var _isBone:Boolean;
      
      private var _waitingSwl:Dictionary;
      
      public function addSwl(swl:Swl, url:String) : void {
         if(!this._swl[url])
         {
            this._swlCount++;
         }
         this._swl[url] = swl;
         if(this._waitingSwl[url])
         {
            this._waitingSwl[url] = false;
            delete this._waitingSwl[[url]];
            dispatchEvent(new SwlEvent(SwlEvent.SWL_LOADED,url));
         }
      }
      
      public function updateSwfState(uri:Uri) : void {
         if(!this._swl[uri.toString()])
         {
            this._swlCount++;
         }
         this._swl[uri.toString()] = false;
      }
      
      public function hasClass(className:String) : Boolean {
         var swlUri:Uri = this._isBone?BoneIndexManager.getInstance().getBoneFile(this.gfxId,className):new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl");
         return !(this._swl[swlUri.toString()] == null);
      }
      
      public function hasClassAvaible(className:String=null) : Boolean {
         if(this.isSingleFile)
         {
            return !(this.getSwl(className) == null);
         }
         var swlUri:Uri = this._isBone?BoneIndexManager.getInstance().getBoneFile(this.gfxId,className):new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl");
         return (!(this._swl[swlUri.toString()] == null)) && (!(this._swl[swlUri.toString()] == false));
      }
      
      public function hasSwl(uri:Uri=null) : Boolean {
         if(!uri)
         {
            return !(this._swlCount == 0);
         }
         return !(this._swl[uri.toString()] == null);
      }
      
      public function getSwl(className:String=null, waitForIt:Boolean=false) : Swl {
         var s:* = undefined;
         var swlUri:Uri = null;
         if((className) || (!this._isBone))
         {
            swlUri = this._isBone?BoneIndexManager.getInstance().getBoneFile(this.gfxId,className):new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl");
            if(this._swl[swlUri.toString()] != false)
            {
               return this._swl[swlUri.toString()];
            }
            if(waitForIt)
            {
               this._waitingSwl[swlUri.toString()] = true;
               return null;
            }
         }
         for each (s in this._swl)
         {
            if(s != false)
            {
               return s;
            }
         }
         return null;
      }
      
      public function get isSingleFile() : Boolean {
         return (!this._isBone) || (!BoneIndexManager.getInstance().hasCustomBone(this.gfxId));
      }
   }
}
