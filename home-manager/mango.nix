{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.mangowm.hmModules.mango
  ];

  options = {
    mango.enable =
      lib.mkEnableOption "enables and configures mangowm";
  };

  config = lib.mkIf config.mango.enable {
    programs.foot.enable = true;
    programs.fuzzel.enable = true;
    wayland.windowManager.mango.enable = true;
    wayland.windowManager.mango.extraConfig = ''
      monitorrule=model:TL140BDXP01-0,width:2560,height:1440,refresh:120,scale:1.66666666,x:0,y:0
      exec-once=dms run
    '';
    wayland.windowManager.mango.settings = {
      # Window effect
      blur = 1;
      blur_layer = 1;
      blur_optimized = 1;
      blur_params = {
        num_passes = 2;
        radius = 5;
        noise = 0.02;
        brightness = 0.9;
        contrast = 0.9;
        saturation = 1.2;
      };

      shadows = 0;
      layer_shadows = 0;
      shadow_only_floating = 1;
      shadows_size = 10;
      shadows_blur = 15;
      shadows_position_x = 0;
      shadows_position_y = 0;
      shadowscolor = "0x000000ff";

      border_radius = 6;
      no_radius_when_single = 0;
      focused_opacity = 1.0;
      unfocused_opacity = 1.0;

      # Animation Configuration (support type: zoom, slide)
      # tag_animation_direction: 1-horizontal, 0-vertical
      animations = 1;
      layer_animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      animation_fade_in = 1;
      animation_fade_out = 1;
      tag_animation_direction = 1;
      zoom_initial_ratio = 0.4;
      zoom_end_ratio = 0.8;
      fadein_begin_opacity = 0.5;
      fadeout_begin_opacity = 0.8;
      animation_duration_move = 500;
      animation_duration_open = 400;
      animation_duration_tag = 350;
      animation_duration_close = 800;
      animation_duration_focus = 0;
      animation_curve = {
        open = "0.46,1.0,0.29,1";
        move = "0.46,1.0,0.29,1";
        tag = "0.46,1.0,0.29,1";
        close = "0.08,0.92,0,1";
        focus = "0.46,1.0,0.29,1";
        opafadeout = "0.5,0.5,0.5,0.5";
        opafadein = "0.46,1.0,0.29,1";
      };

      # Scroller Layout Setting
      scroller_structs = 20;
      scroller_default_proportion = 0.8;
      scroller_focus_center = 0;
      scroller_prefer_center = 0;
      edge_scroller_pointer_focus = 1;
      edge_scroller_focus_allow_speed = 0.0;
      scroller_default_proportion_single = 1.0;
      scroller_proportion_preset = "0.5,0.8,1.0";

      # Master-Stack Layout Setting
      new_is_master = 1;
      default_mfact = 0.55;
      default_nmaster = 1;
      smartgaps = 0;

      # Dwindle Layout Setting
      dwindle_smart_split = 0;
      dwindle_drop_simple_split = 1;
      dwindle_manual_split = 0;
      dwindle_hsplit = 1;
      dwindle_vsplit = 1;
      dwindle_preserve_split = 0;

      # Overview Setting
      hotarea_size = 10;
      enable_hotarea = 0;
      ov_tab_mode = 1;
      ov_no_resize = 1;
      overviewgappi = 5;
      overviewgappo = 30;

      # Misc
      no_border_when_single = 0;
      axis_bind_apply_timeout = 100;
      focus_on_activate = 1;
      idleinhibit_ignore_visible = 0;
      sloppyfocus = 1;
      warpcursor = 1;
      focus_cross_monitor = 0;
      focus_cross_tag = 0;
      enable_floating_snap = 0;
      snap_distance = 30;
      cursor_size = 24;
      drag_tile_to_tile = 1;
      drag_tile_small = 1;

      # keyboard
      repeat_rate = 25;
      repeat_delay = 600;
      numlockon = 0;
      xkb_rules_layout = "se";

      # Trackpad (need relogin to apply)
      disable_trackpad = 0;
      tap_to_click = 1;
      tap_and_drag = 1;
      drag_lock = 1;
      trackpad_natural_scrolling = 0;
      disable_while_typing = 1;
      left_handed = 0;
      middle_button_emulation = 0;
      swipe_min_threshold = 1;

      # mouse (need relogin to apply)
      mouse_natural_scrolling = 0;

      # Appearance
      gappih = 5;
      gappiv = 5;
      gappoh = 10;
      gappov = 10;
      scratchpad_width_ratio = 0.8;
      scratchpad_height_ratio = 0.9;
      borderpx = 4;
      rootcolor = "0x201b14ff";
      bordercolor = "0x444444ff";
      dropcolor = "0x8FBA7C55";
      splitcolor = "0xEB441EFF";
      focuscolor = "0xc9b890ff";
      maximizescreencolor = "0x89aa61ff";
      urgentcolor = "0xad401fff";
      scratchpadcolor = "0x516c93ff";
      globalcolor = "0xb153a7ff";
      overlaycolor = "0x14a57cff";

      # layout support:
      # tile, scroller, grid, deck, monocle, center_tile, vertical_tile, vertical_scroller
      tagrule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:scroller"
        "id:3,layout_name:tile"
        "id:4,layout_name:tile"
        "id:5,layout_name:tile"
        "id:6,layout_name:tile"
        "id:7,layout_name:tile"
        "id:8,layout_name:tile"
        "id:9,layout_name:tile"
      ];

      # Key Bindings
      # key name refer to `xev` or `wev`,
      # mod keys: super, ctrl, alt, shift, none
      bind = [
        # reload config
        "SUPER,r,reload_config"
        "SUPER,d,spawn,fuzzel"
        "SUPER,Return,spawn,foot"
        "SUPER,m,quit"
        "SUPER,Tab,focusstack,next"
        "SUPER,Left,focusdir,left"
        "SUPER,Right,focusdir,right"
        "SUPER,Up,focusdir,up"
        "SUPER,Down,focusdir,down"

        # swap window
        "SUPER+SHIFT,Up,exchange_client,up"
        "SUPER+SHIFT,Down,exchange_client,down"
        "SUPER+SHIFT,Left,exchange_client,left"
        "SUPER+SHIFT,Right,exchange_client,right"

        # switch window status
        "SUPER,g,toggleglobal,"
        "ALT,Tab,toggleoverview,"
        "SUPER,Space,togglefloating,"
        "SUPER,f,togglemaximizescreen,"
        "SUPER+SHIFT,f,togglefullscreen,"
        "SUPER+CTRL,f,togglefakefullscreen,"
        "SUPER,i,minimized,"
        "SUPER,o,toggleoverlay,"
        "SUPER+SHIFT,I,restore_minimized"
        "ALT,z,toggle_scratchpad"

        # scroller layout
        "ALT,e,set_proportion,1.0"
        "ALT,x,switch_proportion_preset,"
        "alt+super+ctrl,Left,scroller_stack,left"
        "alt+super+ctrl,Right,scroller_stack,right"
        "alt+super+ctrl,Up,scroller_stack,up"
        "alt+super+ctrl,Down,scroller_stack,down"

        # dwindle layout (manual split mode)
        "alt+shift,Return,dwindle_toggle_split_direction"

        # switch layout
        "SUPER,n,switch_layout"

        # tag switch
        "CTRL,Left,viewtoleft_have_client,0"
        "CTRL,Right,viewtoright_have_client,0"
        "CTRL+SUPER,Left,tagtoleft,0"
        "CTRL+SUPER,Right,tagtoright,0"

        "SUPER,1,view,1,0"
        "SUPER,2,view,2,0"
        "SUPER,3,view,3,0"
        "SUPER,4,view,4,0"
        "SUPER,5,view,5,0"
        "SUPER,6,view,6,0"
        "SUPER,7,view,7,0"
        "SUPER,8,view,8,0"
        "SUPER,9,view,9,0"

        # tag: move client to the tag and focus it
        # tagsilent: move client to the tag and not focus it
        "SUPER+SHIFT,1,tag,1,0"
        "SUPER+SHIFT,2,tag,2,0"
        "SUPER+SHIFT,3,tag,3,0"
        "SUPER+SHIFT,4,tag,4,0"
        "SUPER+SHIFT,5,tag,5,0"
        "SUPER+SHIFT,6,tag,6,0"
        "SUPER+SHIFT,7,tag,7,0"
        "SUPER+SHIFT,8,tag,8,0"
        "SUPER+SHIFT,9,tag,9,0"

        # monitor switch
        "alt+shift,Left,focusmon,left"
        "alt+shift,Right,focusmon,right"
        "SUPER+Alt,Left,tagmon,left"
        "SUPER+Alt,Right,tagmon,right"

        # gaps
        "ALT+SHIFT,X,incgaps,1"
        "ALT+SHIFT,Z,incgaps,-1"
        "ALT+SHIFT,R,togglegaps"

        # movewin
        "CTRL+SHIFT,Up,movewin,+0,-50"
        "CTRL+SHIFT,Down,movewin,+0,+50"
        "CTRL+SHIFT,Left,movewin,-50,+0"
        "CTRL+SHIFT,Right,movewin,+50,+0"

        # resizewin
        "CTRL+ALT,Up,resizewin,+0,-50"
        "CTRL+ALT,Down,resizewin,+0,+50"
        "CTRL+ALT,Left,resizewin,-50,+0"
        "CTRL+ALT,Right,resizewin,+50,+0"
      ];

      # Mouse Button Bindings
      # btn_left and btn_right can't bind none mod key
      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "NONE,btn_middle,togglemaximizescreen,0"
        "SUPER,btn_right,moveresize,curresize"
      ];

      # Axis Bindings
      axisbind = [
        "SUPER,UP,viewtoleft_have_client"
        "SUPER,DOWN,viewtoright_have_client"
      ];

      # layer rule
      layerrule = [
        "animation_type_open:zoom,layer_name:rofi"
        "animation_type_close:zoom,layer_name:rofi"
      ];
    };
  };
}
