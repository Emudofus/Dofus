package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class MutantTooltipInformation extends Object
    {
        private var _cssUri:String;
        public var infos:GameRolePlayMutantInformations;
        public var wingsEffect:int;
        public var titleName:String;
        public var titleColor:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MutantTooltipInformation));

        public function MutantTooltipInformation(param1:GameRolePlayMutantInformations)
        {
            this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css";
            this.infos = param1;
            return;
        }// end function

        private function onCssLoaded() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = CssManager.getInstance().getCss(this._cssUri);
            _loc_2 = _loc_1.getStyle("itemset");
            this.titleColor = _loc_2["color"];
            return;
        }// end function

    }
}
