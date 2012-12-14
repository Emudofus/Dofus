package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.appearance.*;
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
        public var ornamentAssetId:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterTooltipInformation));

        public function CharacterTooltipInformation(param1:GameRolePlayHumanoidInformations, param2:int)
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css";
            this.infos = param1;
            this.wingsEffect = param2;
            if (param1 is GameRolePlayCharacterInformations)
            {
                _loc_3 = param1 as GameRolePlayCharacterInformations;
                CssManager.getInstance().askCss(this._cssUri, new Callback(this.onCssLoaded));
                for each (_loc_7 in param1.humanoidInfo.options)
                {
                    
                    if (_loc_7 is HumanOptionTitle)
                    {
                        _loc_4 = _loc_7.titleId;
                        _loc_5 = _loc_7.titleParam;
                    }
                    if (_loc_7 is HumanOptionOrnament)
                    {
                        _loc_6 = _loc_7.ornamentId;
                    }
                }
                if (_loc_4)
                {
                    _loc_8 = Title.getTitleById(_loc_4);
                    if (_loc_8)
                    {
                        this.titleName = "« " + _loc_8.name + " »";
                        if (_loc_5)
                        {
                            this.titleName = this.titleName.split("%1").join(_loc_5);
                        }
                    }
                }
                if (_loc_6)
                {
                    _loc_9 = Ornament.getOrnamentById(_loc_6);
                    this.ornamentAssetId = _loc_9.assetId;
                }
            }
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
