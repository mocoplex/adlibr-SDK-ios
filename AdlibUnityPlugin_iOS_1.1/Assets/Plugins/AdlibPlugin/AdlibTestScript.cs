using UnityEngine;

// Example script showing how you can easily call into the AdlibPlugin.
public class AdlibTestScript : MonoBehaviour {
	
	Rect rect = new Rect();
	void OnGUI()
	{
		rect.x = 20;
		rect.y = 200;
		
		rect.width = Screen.width * 0.3f;
		rect.height = Screen.height * 0.1f * 2 / 3;
		// Make the Enable Button
		if (GUI.Button(rect, "Hide")) {
			AdlibPlugin.HideBanner();
		}
		
		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "Show")) {
			AdlibPlugin.ShowBanner(false, false);
		}

		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "LoadInterstitial")) {
			AdlibPlugin.LoadInterstitialAd();
		}

		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "ShowPopBanner")) {
			AdlibPlugin.ShowPopBanner("ff444444",
			                          AdlibPlugin.PopButton.White,
			                          true, 
			                          false,
			                          AdlibPlugin.PopAlign.Bottom,
			                          60);
		}

		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "HidePopBanner")) {
			AdlibPlugin.HidePopBanner();
		}

		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "ShowIcon1")) {
			// RewardLink ID for Test - insert your real ID
			AdlibPlugin.ShowRewardLink("519c29ffe4b00e029838e9ed",
			                           50,
			                           50);
		}
		
		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "ShowIcon2")) {
			// RewardLink ID for Test - insert you real ID
			AdlibPlugin.ShowRewardLink("519c2a0ee4b00e029838e9ee",
			                           240,
			                           400);
		}
		
		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "HideIcon")) {           
			AdlibPlugin.HideRewardLink();
		}
	}
	
	// Use this for initialization
	void Start () {
		AdlibPlugin.ReceivedInterstitial += HandleReceivedInterstitial;
		AdlibPlugin.FailedToReceiveInterstitial += HandleFailedToReceiveInterstitial;
		AdlibPlugin.DismissedInterstitial += HandleDismissedInterstitial;
		AdlibPlugin.ReceivedPopBanner += HandleReceivedPopBanner;
		AdlibPlugin.FailedToReceivePopBanner += HandleFailedToReceivePopBanner;
		AdlibPlugin.DismissedPopBanner += HandleDismissedPopBanner;
		
		AdlibPlugin.InitializeAdlib("52fae879e4b0e91e276dbf76");   // ADLIB_API_KEY for Test - insert your real KEY
		
		AdlibPlugin.ShowBanner(true, true);
	}
	
	public void HandleReceivedInterstitial(string platform) {
		print("Received Interstitial Ad : ");
		print(platform);
	}
	
	public void HandleFailedToReceiveInterstitial() {
		print("Failed Interstitial Ad");
	}
	
	public void HandleDismissedInterstitial() {
		print("Closed Interstitial Ad");
	}

	public void HandleReceivedPopBanner() {
		print("Received PopBanner");
	}
	
	public void HandleFailedToReceivePopBanner() {
		print("Failed PopBanner");
	}
	
	public void HandleDismissedPopBanner() {
		print("Closed PopBanner");
	}
}