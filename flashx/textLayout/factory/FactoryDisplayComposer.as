package flashx.textLayout.factory
{
   import flashx.textLayout.compose.StandardFlowComposer;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.compose.SimpleCompose;
   import flashx.textLayout.elements.BackgroundManager;
   
   use namespace tlf_internal;
   
   public class FactoryDisplayComposer extends StandardFlowComposer
   {
      
      public function FactoryDisplayComposer() {
         super();
      }
      
      override tlf_internal function callTheComposer(param1:int, param2:int) : ContainerController {
         clearCompositionResults();
         var _loc3_:SimpleCompose = TextLineFactoryBase._factoryComposer;
         _loc3_.composeTextFlow(textFlow,-1,-1);
         _loc3_.releaseAnyReferences();
         return getControllerAt(0);
      }
      
      override protected function preCompose() : Boolean {
         return true;
      }
      
      override tlf_internal function createBackgroundManager() : BackgroundManager {
         return new FactoryBackgroundManager();
      }
   }
}
import flashx.textLayout.elements.BackgroundManager;
import flashx.textLayout.compose.TextFlowLine;
import flash.text.engine.TextLine;

class FactoryBackgroundManager extends BackgroundManager
{
   
   function FactoryBackgroundManager() {
      super();
   }
   
   override public function finalizeLine(param1:TextFlowLine) : void {
      var _loc4_:Object = null;
      var _loc2_:TextLine = param1.getTextLine();
      var _loc3_:Array = _lineDict[_loc2_];
      if(_loc3_)
      {
         _loc4_ = _loc3_[0];
         if(_loc4_)
         {
            _loc4_.columnRect = param1.controller.columnState.getColumnAt(param1.columnIndex);
         }
      }
   }
}
