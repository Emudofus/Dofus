package com.ankamagames.tiphon.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.jerakine.data.CensoredContentManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.jerakine.types.Callback;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.types.Swl;
   import flash.events.Event;
   import flash.events.ProgressEvent;


   public class Skin extends EventDispatcher
   {
         

      public function Skin() {
         super();
         this._skinParts=new Array();
         this._skinClass=new Array();
         this._aSkinPartOrdered=new Array();
      }

      private static const _log:Logger = Log.getLogger(getQualifiedClassName(Skin));

      private static var _censoredSkin:Dictionary;

      private static var _alternativeSkin:Dictionary = new Dictionary();

      public static function addAlternativeSkin(gfxId:uint, alternativeGfxId:uint) : void {
         if(!_alternativeSkin[gfxId])
         {
            _alternativeSkin[gfxId]=new Array();
         }
         _alternativeSkin[gfxId].push(alternativeGfxId);
      }

      private var _ressourceCount:uint = 0;

      private var _ressourceLoading:uint = 0;

      private var _skinParts:Array;

      private var _skinClass:Array;

      private var _aSkinPartOrdered:Array;

      private var _validate:Boolean = true;

      public function get complete() : Boolean {
         var skinId:uint = 0;
         if(!this._validate)
         {
            return false;
         }
         var isComplete:Boolean = true;
         for each (skinId in this._aSkinPartOrdered)
         {
            isComplete=(isComplete)&&((Tiphon.skinLibrary.isLoaded(skinId))||(Tiphon.skinLibrary.hasError(skinId)));
         }
         return isComplete;
      }

      public function get validate() : Boolean {
         return this._validate;
      }

      public function set validate(b:Boolean) : void {
         this._validate=b;
         if((b)&&(this.complete))
         {
            this.processSkin();
         }
      }

      public function add(gfxId:uint, alternativeSkinIndex:int=-1) : uint {
         var oldSkinGfxId:int = -1;
         if(!_censoredSkin)
         {
            _censoredSkin=CensoredContentManager.getInstance().getCensoredIndex(2);
         }
         if(_censoredSkin[gfxId])
         {
            gfxId=_censoredSkin[gfxId];
         }
         if((!(alternativeSkinIndex==-1))&&(_alternativeSkin)&&(_alternativeSkin[gfxId])&&(alternativeSkinIndex>_alternativeSkin[gfxId].length))
         {
            oldSkinGfxId=gfxId;
            gfxId=_alternativeSkin[gfxId][alternativeSkinIndex];
         }
         var parts:Array = new Array();
         var i:uint = 0;
         while(i<this._aSkinPartOrdered.length)
         {
            if((!(this._aSkinPartOrdered[i]==gfxId))&&(!(this._aSkinPartOrdered[i]==oldSkinGfxId)))
            {
               parts.push(this._aSkinPartOrdered[i]);
            }
            i++;
         }
         parts.push(gfxId);
         if(this._aSkinPartOrdered.length!=parts.length)
         {
            this._aSkinPartOrdered=parts;
            this._ressourceLoading++;
            Tiphon.skinLibrary.addResource(gfxId,new Uri(TiphonConstants.SWF_SKIN_PATH+gfxId+".swl"));
            Tiphon.skinLibrary.askResource(gfxId,null,new Callback(this.onResourceLoaded,gfxId),new Callback(this.onResourceLoaded,gfxId));
         }
         else
         {
            this._aSkinPartOrdered=parts;
         }
         return gfxId;
      }

      public function getPart(sName:String) : Sprite {
         var p:Sprite = this._skinParts[sName];
         if((p)&&(!p.parent))
         {
            return p;
         }
         if(this._skinClass[sName])
         {
            p=new this._skinClass[sName]();
            this._skinParts[sName]=p;
            return p;
         }
         return null;
      }

      public function reset() : void {
         this._skinParts=new Array();
         this._skinClass=new Array();
         this._aSkinPartOrdered=new Array();
      }

      private function onResourceLoaded(gfxId:uint) : void {
         this._ressourceCount++;
         this._ressourceLoading--;
         this.processSkin();
      }

      private function processSkin() : void {
         var gfxId:uint = 0;
         var lib:Swl = null;
         var classPart:Array = null;
         var className:String = null;
         var i:uint = 0;
         while(i<this._aSkinPartOrdered.length)
         {
            gfxId=this._aSkinPartOrdered[i];
            lib=Tiphon.skinLibrary.getResourceById(gfxId);
            if(!lib)
            {
            }
            else
            {
               classPart=lib.getDefinitions();
               for each (className in classPart)
               {
                  this._skinClass[className]=lib.getDefinition(className);
                  delete this._skinParts[[className]];
               }
            }
            i++;
         }
         if(this.complete)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            dispatchEvent(new Event(ProgressEvent.PROGRESS));
         }
      }
   }

}