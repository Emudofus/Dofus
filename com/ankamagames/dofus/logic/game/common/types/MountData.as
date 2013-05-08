package com.ankamagames.dofus.logic.game.common.types
{
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.jerakine.utils.misc.CopyObject;
   import com.ankamagames.dofus.datacenter.mounts.Mount;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.mounts.MountBehavior;
   import com.ankamagames.dofus.misc.ObjectEffectAdapter;


   public class MountData extends Object
   {
         

      public function MountData() {
         super();
      }

      private static var _dictionary_cache:Dictionary = new Dictionary();

      public static function makeMountData(o:MountClientData, cache:Boolean=true, xpRatio:uint=0) : Object {
         var mountData:Object = null;
         var ability:uint = 0;
         var nEffect:* = 0;
         var i:* = 0;
         if((_dictionary_cache[o.id])&&(cache))
         {
            mountData=getMountFromCache(o.id);
         }
         else
         {
            mountData=CopyObject.copyObject(o,["behaviors","ancestor"]);
            _dictionary_cache[mountData.id]=mountData;
         }
         var mount:Mount = Mount.getMountById(o.model);
         if(!o.name)
         {
            mountData.name=I18n.getUiText("ui.common.noName");
         }
         mountData.id=o.id;
         mountData.model=o.model;
         mountData.description=mount.name;
         mountData.level=o.level;
         mountData.experience=o.experience;
         mountData.experienceForLevel=o.experienceForLevel;
         mountData.experienceForNextLevel=o.experienceForNextLevel;
         mountData.xpRatio=xpRatio;
         try
         {
            mountData.entityLook=TiphonEntityLook.fromString(mount.look);
            mountData.colors=mountData.entityLook.getColors();
         }
         catch(e:Error)
         {
         }
         var a:Vector.<uint> = o.ancestor.concat();
         a.unshift(o.model);
         mountData.ancestor=makeParent(a,0,-1,0);
         mountData.ability=new Array();
         for each (ability in o.behaviors)
         {
            mountData.ability.push(MountBehavior.getMountBehaviorById(ability));
         }
         mountData.effectList=new Array();
         nEffect=o.effectList.length;
         i=0;
         while(i<nEffect)
         {
            mountData.effectList.push(ObjectEffectAdapter.fromNetwork(o.effectList[i]));
            i++;
         }
         mountData.isRideable=o.isRideable;
         mountData.stamina=o.stamina;
         mountData.energy=o.energy;
         mountData.maturity=o.maturity;
         mountData.serenity=o.serenity;
         mountData.love=o.love;
         mountData.fecondationTime=o.fecondationTime;
         mountData.isFecondationReady=o.isFecondationReady;
         mountData.reproductionCount=o.reproductionCount;
         mountData.boostLimiter=o.boostLimiter;
         return mountData;
      }

      public static function getMountFromCache(id:uint) : Object {
         return _dictionary_cache[id];
      }

      private static function makeParent(ancestor:Vector.<uint>, generation:uint, start:int, index:uint) : Object {
         var nextStart:uint = start+Math.pow(2,generation-1);
         var ancestorIndex:uint = nextStart+index;
         if(ancestor.length<=ancestorIndex)
         {
            return null;
         }
         var mount:Mount = Mount.getMountById(ancestor[ancestorIndex]);
         if(!mount)
         {
            return null;
         }
         return 
            {
               mount:mount,
               mother:makeParent(ancestor,generation+1,nextStart,0+2*(ancestorIndex-nextStart)),
               father:makeParent(ancestor,generation+1,nextStart,1+2*(ancestorIndex-nextStart)),
               entityLook:TiphonEntityLook.fromString(mount.look)
            }
         ;
      }


   }

}