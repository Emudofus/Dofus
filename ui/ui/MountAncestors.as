package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.SoundApi;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.EntityDisplayer;
    import d2enums.ShortcutHookListEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2actions.*;
    import d2hooks.*;

    public class MountAncestors 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var soundApi:SoundApi;
        private var _mount:Object;
        private var _names:Array;
        public var btn_close:ButtonContainer;
        public var lbl_title:Label;
        public var lbl_name:Label;
        public var d0:EntityDisplayer;
        public var d1:EntityDisplayer;
        public var d2:EntityDisplayer;
        public var d3:EntityDisplayer;
        public var d4:EntityDisplayer;
        public var d5:EntityDisplayer;
        public var d6:EntityDisplayer;
        public var d7:EntityDisplayer;
        public var d8:EntityDisplayer;
        public var d9:EntityDisplayer;
        public var d10:EntityDisplayer;
        public var d11:EntityDisplayer;
        public var d12:EntityDisplayer;
        public var d13:EntityDisplayer;
        public var d14:EntityDisplayer;


        public function main(param:Object):void
        {
            this._names = new Array();
            var i:int;
            while (i < 15)
            {
                this.uiApi.addComponentHook(this[("d" + i)], "onRollOver");
                this.uiApi.addComponentHook(this[("d" + i)], "onRollOut");
                i++;
            };
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this._mount = param.mount;
            this.lbl_title.text = this.uiApi.getText("ui.mount.ancestors", this._mount.name);
            this.lbl_name.text = this._mount.name;
            this.d0.look = this._mount.ancestor.entityLook;
            this.displayMount(this._mount.ancestor, this.d1, this.d2);
            this._names[this.d0.name] = this._mount.description;
            if (this._mount.ancestor.father)
            {
                this.displayMount(this._mount.ancestor.father, this.d3, this.d4);
                this.displayMount(this._mount.ancestor.mother, this.d5, this.d6);
                if (this._mount.ancestor.father.father)
                {
                    this.displayMount(this._mount.ancestor.father.father, this.d7, this.d8);
                    this.displayMount(this._mount.ancestor.father.mother, this.d9, this.d10);
                };
                if (this._mount.ancestor.mother.father)
                {
                    this.displayMount(this._mount.ancestor.mother.father, this.d11, this.d12);
                    this.displayMount(this._mount.ancestor.mother.mother, this.d13, this.d14);
                };
            };
            this.uiApi.addComponentHook(this.btn_close, "onRelease");
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
            this._mount = null;
            this._names = null;
        }

        private function displayMount(mountInfo:Object, ed1:Object, ed2:Object):void
        {
            if (mountInfo.father)
            {
                ed1.look = mountInfo.father.entityLook;
                this._names[ed1.name] = mountInfo.father.mount.name;
            };
            if (mountInfo.mother)
            {
                ed2.look = mountInfo.mother.entityLook;
                this._names[ed2.name] = mountInfo.mother.mount.name;
            };
        }

        public function onRollOver(target:Object):void
        {
            var textTooltip:Object = this.uiApi.textTooltipInfo(this._names[target.name]);
            if (textTooltip)
            {
                this.uiApi.showTooltip(textTooltip, target, false, "standard", 1, 7, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_close)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }


    }
}//package ui

