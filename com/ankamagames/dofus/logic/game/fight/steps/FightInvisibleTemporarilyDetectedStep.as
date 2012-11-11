package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;

    public class FightInvisibleTemporarilyDetectedStep extends AbstractSequencable implements IFightStep
    {
        private var _duplicateSprite:AnimatedCharacter;
        private var _cellId:int;
        private var _fadeTimer:Timer;

        public function FightInvisibleTemporarilyDetectedStep(param1:AnimatedCharacter, param2:int)
        {
            var _loc_3:* = EntitiesManager.getInstance().getFreeEntityId();
            this._duplicateSprite = new AnimatedCharacter(_loc_3, param1.look.clone());
            this._cellId = param2;
            this._fadeTimer = new Timer(25, 40);
            this._fadeTimer.addEventListener(TimerEvent.TIMER, this.onFade);
            return;
        }// end function

        public function get stepType() : String
        {
            return "invisibleTemporarilyDetected";
        }// end function

        override public function start() : void
        {
            this._duplicateSprite.filters = [new BlurFilter(5, 5)];
            this._duplicateSprite.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 30, 30, 30);
            EntitiesDisplayManager.getInstance().displayEntity(this._duplicateSprite, MapPoint.fromCellId(this._cellId));
            this._fadeTimer.start();
            executeCallbacks();
            return;
        }// end function

        override public function clear() : void
        {
            this._fadeTimer.removeEventListener(TimerEvent.TIMER, this.onFade);
            this._fadeTimer = null;
            EntitiesDisplayManager.getInstance().removeEntity(this._duplicateSprite);
            this._duplicateSprite.destroy();
            this._duplicateSprite = null;
            return;
        }// end function

        private function onFade(event:Event) : void
        {
            if (!this._duplicateSprite)
            {
                return;
            }
            this._duplicateSprite.alpha = this._duplicateSprite.alpha - 0.025;
            if (this._duplicateSprite.alpha < 0.025)
            {
                this.clear();
            }
            return;
        }// end function

    }
}
