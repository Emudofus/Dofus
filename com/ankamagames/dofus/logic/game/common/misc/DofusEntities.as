package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.logger.Log;
   
   public class DofusEntities extends Object
   {
      
      public function DofusEntities() {
         super();
      }
      
      private static const LOCALIZER_DEBUG:Boolean = true;
      
      private static const _log:Logger;
      
      private static var _atouin:Atouin;
      
      private static var _localizers:Vector.<IEntityLocalizer>;
      
      public static function getEntity(entityId:int) : IEntity {
         var localizer:IEntityLocalizer = null;
         var foundEntity:IEntity = null;
         for each(localizer in _localizers)
         {
            foundEntity = localizer.getEntity(entityId);
            if(foundEntity)
            {
               return foundEntity;
            }
         }
         return _atouin.getEntity(entityId);
      }
      
      public static function registerLocalizer(localizer:IEntityLocalizer) : void {
         var currentLocalizer:IEntityLocalizer = null;
         var clazz:String = getQualifiedClassName(localizer);
         var currentClazz:String = null;
         for each(currentLocalizer in _localizers)
         {
            currentClazz = getQualifiedClassName(currentLocalizer);
            if(currentClazz == clazz)
            {
               throw new Error("There\'s more than one " + currentClazz + " localizer added to DofusEntites. Nope, that won\'t work.");
            }
            else
            {
               continue;
            }
         }
         _localizers.push(localizer);
      }
      
      public static function reset() : void {
         var localizer:IEntityLocalizer = null;
         var i:int = 0;
         while(i < _localizers.length)
         {
            localizer = _localizers[i];
            localizer.unregistered();
            i++;
         }
         _localizers = new Vector.<IEntityLocalizer>();
      }
   }
}
