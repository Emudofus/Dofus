package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.system.LoaderContext;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   
   public class MountWrapper extends ItemWrapper implements IDataCenter
   {
      
      public function MountWrapper() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(MountWrapper));
      
      private static var _mountUtil:Object = new Object();
      
      private static var _uriLoaderContext:LoaderContext;
      
      public static function create() : MountWrapper {
         var _loc2_:EffectInstance = null;
         var _loc1_:MountWrapper = new MountWrapper();
         _mountUtil = PlayedCharacterManager.getInstance().mount;
         if(_mountUtil)
         {
            _loc1_.mountId = _mountUtil.model;
            _loc1_.effects = new Vector.<EffectInstance>();
            for each (_loc2_ in _mountUtil.effectList)
            {
               _loc1_.effects.push(_loc2_);
            }
            _loc1_.level = _mountUtil.level;
         }
         else
         {
            _loc1_.mountId = 0;
            _loc1_.effects = new Vector.<EffectInstance>();
            _loc1_.level = 0;
         }
         _loc1_.itemSetId = -1;
         return _loc1_;
      }
      
      public var mountId:int;
      
      private var _uri:Uri;
      
      private var _uriPngMode:Uri;
      
      override public function get name() : String {
         if(!_mountUtil)
         {
            return "";
         }
         return _mountUtil.description;
      }
      
      override public function get description() : String {
         if(!_mountUtil)
         {
            return "";
         }
         var _loc1_:String = I18n.getUiText("ui.mount.description",[_mountUtil.name,_mountUtil.level,_mountUtil.xpRatio]);
         return _loc1_;
      }
      
      override public function get isWeapon() : Boolean {
         return false;
      }
      
      override public function get type() : Object {
         return {"name":I18n.getUiText("ui.common.ride")};
      }
      
      override public function get iconUri() : Uri {
         return this.getIconUri(true);
      }
      
      override public function get fullSizeIconUri() : Uri {
         return this.getIconUri(false);
      }
      
      override public function get errorIconUri() : Uri {
         return null;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      override public function getIconUri(param1:Boolean=true) : Uri {
         if(param1)
         {
            this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/mounts/").concat(this.mountId).concat(".png"));
            return this._uriPngMode;
         }
         if(this._uri)
         {
            return this._uri;
         }
         this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/mounts/").concat(this.mountId).concat(".swf"));
         if(!_uriLoaderContext)
         {
            _uriLoaderContext = new LoaderContext();
            AirScanner.allowByteCodeExecution(_uriLoaderContext,true);
         }
         this._uri.loaderContext = _uriLoaderContext;
         return this._uri;
      }
      
      override public function get info1() : String {
         return null;
      }
      
      override public function get timer() : int {
         return 0;
      }
      
      override public function get active() : Boolean {
         return true;
      }
      
      override public function update(param1:uint, param2:uint, param3:uint, param4:uint, param5:Vector.<ObjectEffect>) : void {
         var _loc6_:EffectInstance = null;
         _mountUtil = PlayedCharacterManager.getInstance().mount;
         if(_mountUtil)
         {
            this.mountId = _mountUtil.model;
            effects = new Vector.<EffectInstance>();
            for each (_loc6_ in _mountUtil.effectList)
            {
               effects.push(_loc6_);
            }
            level = _mountUtil.level;
         }
         else
         {
            this.mountId = 0;
            effects = new Vector.<EffectInstance>();
            level = 0;
         }
      }
      
      override public function toString() : String {
         return "[MountWrapper#" + this.mountId + "]";
      }
   }
}
