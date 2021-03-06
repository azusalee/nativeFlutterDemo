package com.example.fluttertestapp

import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.findNavController
import com.example.fluttertestapp.databinding.FragmentFirstBinding
import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostRouteOptions
import io.flutter.embedding.android.FlutterActivity

/**
 * A simple [Fragment] subclass as the default destination in the navigation.
 */
class FirstFragment : Fragment() {

    private var _binding: FragmentFirstBinding? = null

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {

        _binding = FragmentFirstBinding.inflate(inflater, container, false)
        return binding.root

    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.buttonFirst.setOnClickListener {
            //findNavController().navigate(R.id.action_FirstFragment_to_SecondFragment)
            var options = FlutterBoostRouteOptions.Builder()
                .pageName(FlutterRoutes.message)
                .arguments(mapOf( "name" to "myName" ))
                .requestCode(1111)
                .build()

            FlutterBoost.instance().open(options)

            //FlutterChannelHandler.changeFlutterRootRoute(FlutterRoutes.message)
            ////startActivity(FlutterActivity
                //.withCachedEngine("zeek_flutter_engine")
                //.build(this.requireContext()))
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}