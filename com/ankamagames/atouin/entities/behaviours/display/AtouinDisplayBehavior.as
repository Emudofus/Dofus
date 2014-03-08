package com.ankamagames.atouin.entities.behaviours.display
{
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class AtouinDisplayBehavior extends Object implements IDisplayBehavior
   {
      
      public function AtouinDisplayBehavior() {
         super();
         if(_self != null)
         {
            throw new SingletonError("A singleton class shouldn\'t be instancied directly!");
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AtouinDisplayBehavior));
      
      private static var _self:AtouinDisplayBehavior;
      
      public static function getInstance() : AtouinDisplayBehavior {
         if(_self == null)
         {
            _self = new AtouinDisplayBehavior();
         }
         return _self;
      }
      
      public function display(param1:IDisplayable, param2:uint=0) : void {
         var _loc3_:IEntity = param1 as IEntity;
         EntitiesManager.getInstance().addAnimatedEntity(_loc3_.id,_loc3_,param2);
      }
      
      public function remove(param1:IDisplayable) : void {
         EntitiesManager.getInstance().removeEntity((param1 as IEntity).id);
      }
      
      public function getAbsoluteBounds(param1:IDisplayable) : IRectangle {
         return EntitiesDisplayManager.getInstance().getAbsoluteBounds(param1);
      }
   }
}
