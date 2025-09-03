import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import Layout from './components/Layout'
import Dashboard from './pages/Dashboard'
import Competencies from './pages/Competencies'
import Guides from './pages/Guides'
import Assessments from './pages/Assessments'
import DataExport from './pages/DataExport'
import './App.css'

const queryClient = new QueryClient()

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <Router>
        <Layout>
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/competencies" element={<Competencies />} />
            <Route path="/guides" element={<Guides />} />
            <Route path="/assessments" element={<Assessments />} />
            <Route path="/export" element={<DataExport />} />
          </Routes>
        </Layout>
      </Router>
    </QueryClientProvider>
  )
}

export default App
