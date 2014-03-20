using System;
using System.ComponentModel;
using System.Collections;
using System.Runtime.InteropServices;
using UnityEngine;

using AdlibMobilePlugin = AdlibPluginiOS;

public class AdlibPlugin : MonoBehaviour {

	public class PopButton
	{
		private string buttonColor;
		private PopButton(string value)
		{
			this.buttonColor = value;
		}
		
		public override string ToString()
		{
			return buttonColor;
		}
		
		public static PopButton White = new PopButton("WHITE");
		public static PopButton Black = new PopButton("BLACK");
	}
	
	public class PopAlign
	{
		private string align;
		private PopAlign(string value)
		{
			this.align = value;
		}
		
		public override string ToString()
		{
			return align;
		}
		
		public static PopAlign Top = new PopAlign("TOP");
		public static PopAlign Bottom = new PopAlign("BOTTOM");
		public static PopAlign Left = new PopAlign("LEFT");
		public static PopAlign Right = new PopAlign("RIGHT");
	}

	public static event Action<string> ReceivedInterstitial = delegate {};
	public static event Action FailedToReceiveInterstitial = delegate {};
	public static event Action DismissedInterstitial = delegate {};
	public static event Action ReceivedPopBanner = delegate {};
	public static event Action FailedToReceivePopBanner = delegate {};
	public static event Action DismissedPopBanner = delegate {};
	
	void Awake() {
		gameObject.name = this.GetType().ToString();
		SetCallbackHandlerName(gameObject.name);
		DontDestroyOnLoad(this);
	}
	
	public static void InitializeAdlib(string adlibKey) {
		// Call plugin only when running on real device.
		if (Application.platform == RuntimePlatform.OSXEditor)
		{
			return;
		}
		AdlibMobilePlugin.Initialize(adlibKey);
	}
	
	public static void SetCallbackHandlerName(string name) {
		if (Application.platform == RuntimePlatform.OSXEditor)
		{
			return;
		}
		AdlibMobilePlugin.SetCallbackHandlerName(name);
	}
	
	public static void ShowBanner(bool positionAtTop, bool useHouseBanner) {
		AdlibMobilePlugin.ShowBanner(positionAtTop, useHouseBanner);
	}
	
	public static void HideBanner() {
		AdlibMobilePlugin.HideBanner();
	}
	
	public static void LoadInterstitialAd() {
		AdlibMobilePlugin.LoadInterstitialAd();
	}
	
	public static void ShowPopBanner(string frameColor, PopButton btnColor, bool useInAnim, bool useOutAnim, PopAlign btnAlign, int padding) {
		AdlibMobilePlugin.ShowPopBanner(frameColor, btnColor.ToString(), useInAnim, useOutAnim, btnAlign.ToString(), padding);
	}
	
	public static void HidePopBanner() {
		AdlibMobilePlugin.HidePopBanner();
	}
	
	public static void ShowRewardLink(string linkId, int x, int y) {
		AdlibMobilePlugin.ShowRewardLink(linkId, x, y);
	}
	
	public static void HideRewardLink() {
		AdlibMobilePlugin.HideRewardLink();
	}
	
	public void OnReceivedInterstitialAd(string platform)
	{
		ReceivedInterstitial(platform);
	}
	
	public void OnFailedToReceiveInterstitialAd(string unusedMessage)
	{
		FailedToReceiveInterstitial();
	}
	
	public void OnClosedInterstitialAd(string unusedMessage)
	{
		DismissedInterstitial();
	}

	public void OnReceivedPopBanner(string unusedMessage)
	{
		ReceivedPopBanner();
	}
	
	public void OnFailedToReceivePopBanner(string unusedMessage)
	{
		FailedToReceivePopBanner();
	}
	
	public void OnClosedPopBanner(string unusedMessage)
	{
		DismissedPopBanner();
	}
}