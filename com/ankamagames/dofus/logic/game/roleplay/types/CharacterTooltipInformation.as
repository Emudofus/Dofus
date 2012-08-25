package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class CharacterTooltipInformation extends Object
    {
        private var _cssUri:String;
        public var infos:GameRolePlayHumanoidInformations;
        public var wingsEffect:int;
        public var titleName:String;
        public var titleColor:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterTooltipInformation));

        public function CharacterTooltipInformation(param1:GameRolePlayHumanoidInformations, param2:int)
        {
            var _loc_3:GameRolePlayCharacterInformations = null;
            var _loc_4:Title = null;
            this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css";
            this.infos = param1;
            this.wingsEffect = param2;
            if (param1 is GameRolePlayCharacterInformations)
            {
                _loc_3 = param1 as GameRolePlayCharacterInformations;
                if (_loc_3.humanoidInfo.titleId)
                {
                    _loc_4 = Title.getTitleById(param1.humanoidInfo.titleId);
                    if (_loc_4)
                    {
                        this.titleName = "" + _loc_4.name + " ";
                        if (_loc_3.humanoidInfo.titleParam)
                        {
                            this.titleName = this.titleName.split("%1").join(_loc_3.humanoidInfo.titleParam);
                        }
                        CssManager.getInstance().askCss(this._cssUri, new Callback(this.onCssLoaded));
                    }
                }
            }
            return;
        }// end function

        private function onCssLoaded() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = CssManager.getInstance().getCss(this._cssUri);
            _loc_2 = _loc_1.getStyle("itemset");
            this.titleColor = _loc_2["color"];
            return;
        }// end function

    }
}
