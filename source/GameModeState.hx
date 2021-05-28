package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;

class GameModeState extends MusicBeatState
{
	static var curSelected:Int = 0;
	var textMenuItems:Array<String> = ['SCREEN MODE', 'AUTO MODE', 'RELAXED MODE', 'CHAMPIONS MODE', 'PERFECT MODE', 'RESET'];
	var textMenuDescriptions:Array<Dynamic> = 
	[
		'Adds the following color over gameplay, allowing the recording of only UI elements. (For Auto, Shift + Return)', 
		'Better than fnfbot, sit back and relax!', 
		'Good for practicing, caps scrollspeed (change with left/right), and no health to worry about!',
		'Go for your best shot! Pausing is disabled, single run per-week, and only 4 shots to miss!',
		'Go for a perfect! Unlike champions mode, you only get one shot for the week!',
		'Reset any applied modes, back to the basic experience.'
	];
	var grpOptionsTexts:FlxTypedGroup<Alphabet>;
	var Description:FlxText;
	
    override public function create()
    {
        super.create();
		
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		//menuBG.color = 0xFF9e102c;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
		
		Description = new FlxText(FlxG.width * 0.6, 7, 500, "", 32);
		Description.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		add(Description);
		
		makeOptionsText();
		changeSelection(0);
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		OptionsMenu.newmenucolor = 0xFF9e102c;
		FlxTween.color(menuBG, 0.6, OptionsMenu.oldmenucolor, OptionsMenu.newmenucolor,{
			onComplete: function(t:FlxTween)
			{
				OptionsMenu.oldmenucolor = 0xFF9e102c;
			}
		});
    }
	
	function makeOptionsText()
	{
		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		for (i in 0...textMenuItems.length)
		{
			var optionText:Alphabet = new Alphabet(0, 30 + (70 * i), textMenuItems[i], true, false);
			optionText.ID = i;
			optionText.x += 10*(i+1);
			grpOptionsTexts.add(optionText);
		}
	}
	
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpOptionsTexts.length - 1;
		if (curSelected >= grpOptionsTexts.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptionsTexts.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
				item.alpha = 1;
		}
		
		Description.text = textMenuDescriptions[curSelected];
	}
	
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
		
		if (controls.BACK)
			FlxG.switchState(new OptionsMenu());
		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);
		if (controls.ACCEPT)
		{
			trace(textMenuItems[curSelected]);
			PlayState.modes = [false, false, false, false, false];
				
			if (!(textMenuItems[curSelected] == 'SCREEN MODE'))
				FlxG.switchState(new OptionsMenu());
			
			switch (textMenuItems[curSelected])
			{
				case 'SCREEN MODE':
				{
					if (FlxG.keys.pressed.SHIFT)
					{
						trace("ASFGJKKL:AFG");
						PlayState.modes[1] = true;
					}
					PlayState.modes[0] = true;
					FlxG.switchState(new CinematicColorState());
				}
				case 'AUTO MODE':
					PlayState.modes[1] = true;
				case 'RELAXED MODE':
					PlayState.modes[2] = true;
				case 'CHAMPIONS MODE':
					PlayState.modes[3] = true;
				case 'PERFECT MODE':
					PlayState.modes[4] = true;	
			}
		}
    }
}