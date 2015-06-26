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
			AdlibPlugin.ShowBanner(false);
		}

		rect.y = rect.y + rect.height + 10;
		if (GUI.Button(rect, "LoadInterstitial")) {
			AdlibPlugin.LoadInterstitialAd();
		}
	}
	
	// Use this for initialization
	void Start () {
		AdlibPlugin.ReceivedInterstitial += HandleReceivedInterstitial;
		AdlibPlugin.FailedToReceiveInterstitial += HandleFailedToReceiveInterstitial;
		AdlibPlugin.DismissedInterstitial += HandleDismissedInterstitial;
		
		AdlibPlugin.InitializeAdlib("550787410cf2833915d71f3b");   // ADLIB_API_KEY for Test - insert your real KEY
		
		AdlibPlugin.ShowBanner(false);
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
}