package flashx.textLayout.factory
{
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;

    public class FactoryDisplayComposer extends StandardFlowComposer
    {

        public function FactoryDisplayComposer()
        {
            return;
        }// end function

        override function callTheComposer(param1:int, param2:int) : ContainerController
        {
            clearCompositionResults();
            var _loc_3:* = TextLineFactoryBase._factoryComposer;
            _loc_3.composeTextFlow(textFlow, -1, -1);
            _loc_3.releaseAnyReferences();
            return getControllerAt(0);
        }// end function

        override protected function preCompose() : Boolean
        {
            return true;
        }// end function

        override function createBackgroundManager() : BackgroundManager
        {
            return new FactoryBackgroundManager();
        }// end function

    }
}

import flashx.textLayout.compose.*;

import flashx.textLayout.container.*;

import flashx.textLayout.elements.*;

class FactoryBackgroundManager extends BackgroundManager
{

    function FactoryBackgroundManager()
    {
        return;
    }// end function

    override public function finalizeLine(param1:TextFlowLine) : void
    {
        var _loc_4:* = null;
        var _loc_2:* = param1.getTextLine();
        var _loc_3:* = _lineDict[_loc_2];
        if (_loc_3)
        {
            _loc_4 = _loc_3[0];
            if (_loc_4)
            {
                _loc_4.columnRect = param1.controller.columnState.getColumnAt(param1.columnIndex);
            }
        }
        return;
    }// end function

}

